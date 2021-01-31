pipeline {
    agent any
    stages{
        stage("Validate") {
            steps{
                echo "========Validating changes========"
            }
        }
        stage("Test") { 
            steps{
                echo "====++ Testing with terratest ++++===="
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