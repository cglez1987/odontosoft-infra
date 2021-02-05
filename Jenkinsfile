pipeline {
    agent any
    environment{
        VARS_LOCATION = ''
        ENVIRONMENT_NAME = 'dev'
    }
    stages{
        stage("Configure environment"){
            agent {
                docker {
                   image 'amazon/aws-cli'
                   args  "--entrypoint=''"
                }
            }            
            steps {
                script{
                    echo "Preparing environment"
                    if ("${env.GIT_BRANCH}" == 'master')
                    {
                        VARS_LOCATION = '/prod/tf_vars_location'
                        ENVIRONMENT_NAME = 'prod'
                    }
                    else
                    {
                        VARS_LOCATION = '/dev/tf_vars_location'
                    }
                    echo "========Preparing the environment========="
                    dir("${ENVIRONMENT_NAME}"){
                        sh "aws s3 cp \$(aws ssm get-parameter --name ${VARS_LOCATION} --region us-east-1 --query Parameter.Value --output text) ${ENVIRONMENT_NAME}.auto.tfvars"
                        stash includes: "${ENVIRONMENT_NAME}.auto.tfvars", name: 'terraform_variables_file'
                    }
                }
            }
        }
        stage("Initialization && Validation") {
            steps{
                dir("${ENVIRONMENT_NAME}"){
                    echo "========Initializing terraform modules========"
                    ansiColor('xterm'){
                        unstash 'terraform_variables_file'
                        sh 'terraform --version'
                        sh 'terraform init'
                    }
                    echo "========Validate terraform files========"
                    ansiColor('xterm'){
                        sh 'terraform validate'
                    }
                }
            }
        }
        stage("Planification") { 
           /* agent {
                docker {
                    image 'hashicorp/terraform:light'
                    args  "--entrypoint=''"
                }
            } */
            steps{
                dir("${ENVIRONMENT_NAME}"){
                    echo "====++ Executing terraform plan to review the changes ++++===="
                    ansiColor('xterm'){
                        unstash 'terraform_variables_file'
                        sh "terraform plan -out=${ENVIRONMENT_NAME}-plan"
                    }
                }
            }
        }
        stage("Manual Approval"){
            when {branch 'main'}
            steps{
                echo "====++++ Waiting for manual approval ++++===="
                script{
                    approvalUser = input(id: 'userInput', message: 'Do you approve this plan?', submitter: 'admin', submitterParameter: 'approvalUser')
                    tagVersion = input(id: 'tagVersion', message: 'Enter the tag version: ', parameters: [string(defaultValue: '', description: '', name: 'Tag Version')])
                }
            }
        }
        stage("Deploy") {
            when {branch 'main'}
            steps{
                dir("${ENVIRONMENT_NAME}"){
                    echo "====++ Applying the changes in the dev stage ++++===="
                    ansiColor('xterm'){
                        unstash 'terraform_variables_file'
                        sh "terraform apply ${ENVIRONMENT_NAME}-plan"
                    }
                }
            }
        }
        stage("Release"){
            environment { 
				GIT_AUTH = credentials('GitHub-UserPass') 
			}
            steps{
                echo "====++++Creating release with tag++++===="
				sh "git config --local credential.helper '!f() { echo username=\\$GIT_AUTH_USR; echo password=\\$GIT_AUTH_PSW; }; f'"
                sh "git fetch --tags"
				sh "git tag -a ${tagVersion} -m ${BUILD_TAG}"
				sh "git push --tags origin"
            }
        }
        stage("Cleaning"){
            steps{
                dir("${ENVIRONMENT_NAME}"){
                echo "====++++Cleaning the infra++++===="
                sh 'terraform destroy --auto-approve'
                }
            }
        }
    }
    post{
        success{
            echo 'Cleaning the workspace'
            cleanWs()
        }
    }
}