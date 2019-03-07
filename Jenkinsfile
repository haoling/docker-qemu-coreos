node(label="docker") {
    def app
    stage('Clone repository') {
        checkout scm
    }
    stage('Build image') {
        app = docker.build("haoling/qemu-coreos")
    }
    stage('Push image') {
        docker.withRegistry('https://drive.fei-yen.jp:5443') {
            app.push("${env.BUILD_NUMBER}")
            app.push("latest")
        }
    }
}
