pipeline{
    agent{
        label any
    }
    stages{
        stage("SourceCode"){
            steps{
                echo "========executing Source Code========"
                git branch: 'main', credentialsId: 'GitHub', url: 'https://github.com/cglez1987/odontosoft-infra.git'
            }
        }
        stage("Build"){
            steps{
                echo "====++++executing ++++===="
            }
            post{
                always{
                    echo "====++++always++++===="
                }
                success{
                    echo "====++++ executed successfully++++===="
                }
                failure{
                    echo "====++++ execution failed++++===="
                }
        
            }
        }
    }
    post{
        always{
            echo "========always========"
        }
        success{
            echo "========pipeline executed successfully ========"
        }
        failure{
            echo "========pipeline execution failed========"
        }
    }
}