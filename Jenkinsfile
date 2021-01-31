pipeline {
    agent any
    stages{
        stage("SourceCode") {
            steps{
                echo "========executing Source Code========"
            }
        }
        stage("Build") { 
            steps{
                echo "====++++executing ++++===="
            }
        }
    }
    post {
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