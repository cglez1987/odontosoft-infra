pipeline{
    agent{
        label any
    }
    stages{
        stage("Source Code"){
            steps{
                echo "========executing A========"
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