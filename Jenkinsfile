import groovy.json.JsonSlurperClassic
def jsonParse(def json) {
    new groovy.json.JsonSlurperClassic().parseText(json)
}
pipeline {
    agent any
    stages {
        stage("Paso 1: Compiliar"){
            steps {
                script {
                sh "echo 'Compile Code!'"
                // Run Maven on a Unix agent.
                sh "./mvnw clean compile -e"
                }
            }
        }
        stage("Paso 2: Testear"){
            steps {
                script {
                sh "echo 'Test Code!'"
                // Run Maven on a Unix agent.
                sh "./mvnw clean test -e"
                }
            }
        }
        stage("Paso 3: Build .Jar"){
            steps {
                script {
                sh "echo 'Build .Jar!'"
                // Run Maven on a Unix agent.
                sh "./mvnw clean package -e"
                }
            }
        }
        stage("Paso 4: Análisis SonarQube"){
            steps {
                withSonarQubeEnv('sonarqube') {
                    sh "echo 'Calling sonar Service in another docker container!'"
                    // Run Maven on a Unix agent to execute Sonar.
                    sh './mvnw clean verify sonar:sonar -Dsonar.projectKey=custom-project-key -Dsonar.projectName=project-lab4'
                }
            }
        }
        stage("Paso 4: Run .Jar"){
            steps {
                script {
                sh "echo 'Run .Jar!'"
                // Run SpringBoot on a Unix agent.
                sh "nohup bash mvnw spring-boot:run &"
                }
            }
        }
        stage("Paso 5: Test App"){
                steps {
                    script {
                    sh "echo 'Test App!'"
                    // Run SpringBoot on a Unix agent.
                    sh "curl -X GET 'http://localhost:8080/rest/mscovid/test?msg=testing'"
                    }
                }
            }
        } 
    post {
        always {
            sh "echo 'fase always executed post'"
        }
        success {
            sh "echo 'fase success'"
        }
        failure {
            sh "echo 'fase failure'"
        }
    }
}
