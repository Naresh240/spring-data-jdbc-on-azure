node{
    stage("Source Code Management"){
        git 'https://github.com/Naresh240/spring-data-jdbc-on-azure.git'
    }
    stage('Build Maven'){
	def MAVEN_HOME = tool name: 'maven3', type: 'maven'
	def MVN_CMD="${MAVEN_HOME}/bin/mvn"
		sh "${MVN_CMD} clean  package"
	}
    stage("Build Docker Image"){
		sh 'docker build -t naresh240/spring-data-jdbc-on-azure:latest .'
    }
    stage('Push to Docker Hub'){
        withCredentials([usernamePassword(credentialsId: 'dockerhub', passwordVariable: 'dockerpwd', usernameVariable: 'dockeruname')]) {
			sh 'docker login -u ${dockeruname} -p ${dockerpwd}'
		}
        sh 'docker push naresh240/spring-data-jdbc-on-azure:latest'
    }

    stage('Deploy') {
        withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'aws_configure', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
            withCredentials([kubeconfigFile(credentialsId: 'kube_config', variable: 'KUBECONFIG')]) {
				sh 'helm install spring-data-jdbc-on-azure chart'
            }
        }
    }
    stage('Check pods'){
		
				sh 'kubectl get pods'
		
    }
}
