pipeline {    
    agent { label 'agent-1' }
    stages {
        stage('Checkout code') {
            steps {
                checkout scm
            }
        }

        stage('Deploy with ansible playbook') {
            steps {

                ansiblePlaybook(
                    credentialsId: 'ssh_ansible', 
                    vaultCredentialsId: 'vault_pass',
                    sudoUser: 'admin'
                    sudo: true, 
                    inventory: 'hosts', 
                    playbook: 'Playbook.yml')
            }
        }
        
        stage('Play Integration tests') {
            steps {
                sh '''
                    nginx_IP=$(docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' nginx)
                    answer_code=$(curl -I $nginx_IP:80 2>/dev/null | head -n1 | awk '{print $2}')
                    if (( answer_code == 200 )); 
                        then 
                            echo "SUCCESS";
                        else
                            echo "FAILURE. Server return $answer_code";
                    fi
                '''
            }               
        }
    }       
}
