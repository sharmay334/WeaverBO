node  {

   stage 'Checkout'


    checkout scm

   stage 'Build'
         sh "export"  
         def mvnHome = tool 'M3'
         def buildStatus=-1
         def  commitId
       
       
   slackSend color: "#439FE0", message: "Build Number:${BUILD_NUMBER} Started For: ${BRANCH_NAME}",  teamDomain: 'skilrock', token: 'PJZoglka3a5W4T6fZUfLwWfE'

            buildStatus = sh returnStatus: true, script: "${mvnHome}/bin/mvn clean package -DVERSION=${env.BUILD_NUMBER} findbugs:findbugs pmd:pmd"

       

        /*   buildStatus=  sh  returnStatus: true, script:"${mvnHome}/bin/mvn clean package -DVERSION=SNAPSHOT  findbugs:findbugs  -Dfindbugs.maxRank=1 pmd:pmd -DminimumPriority=3" */

       
sh "git rev-parse --short HEAD > .git/commit-id"                        
commitId = readFile('.git/commit-id').trim()
      
     echo commitId
         echo  "BuildStatusPrinting"
         echo  "${buildStatus}"
         if (buildStatus !=0){
 
   slackSend color: "#439FE0", message: "Build Number:${BUILD_NUMBER} Failed For: ${BRANCH_NAME}",  teamDomain: 'skilrock', token: 'PJZoglka3a5W4T6fZUfLwWfE'

httpRequest customHeaders: [[name: 'PRIVATE-TOKEN', value: "${GIT_TOKEN}"]], httpMode: 'POST', url: "${GIT_URL}${IGAME_BO_ID}/statuses/${commitId}?state=failed"

       error 'Build Failed'
           }
     
          if(buildStatus==0){
  
   slackSend color: "#439FE0", message: "Build Number:${BUILD_NUMBER} Success For: ${BRANCH_NAME}",  teamDomain: 'skilrock', token: 'PJZoglka3a5W4T6fZUfLwWfE'

httpRequest customHeaders: [[name: 'PRIVATE-TOKEN', value: "${GIT_TOKEN}"]], httpMode: 'POST', url: "${GIT_URL}${IGAME_BO_ID}/statuses/${commitId}?state=success"
          }

        junit allowEmptyResults: true, testResults: 'target/surefire-reports/*.xml'



       publishHTML([allowMissing: true, alwaysLinkToLastBuild: false, keepAll: false, reportDir: 'target/site/jacoco', reportFiles: 'index.html', reportName: 'Code Coverage'])


   

   stage 'Create  Package'

    sh "${mvnHome}/bin/mvn assembly:single -DVERSION=${env.BUILD_NUMBER}"

    def groupId = getPomValue(readFile("pom.xml"), "groupId")
    def artifactId = getPomValue(readFile("pom.xml"), "artifactId")
    def version= getPomValue(readFile("pom.xml"), "version")
    def releaseVersion = version.substring(0, version.lastIndexOf("_") + 1) + "${env.BUILD_NUMBER}"
    
    
    
    
    stage ' Publish Package'
            long start_time_5 = System.currentTimeMillis();
            long wait_time_5 = 60000;
            long end_time_5 = start_time_5 + wait_time_5;
            def status_5=0
            while (System.currentTimeMillis() < end_time_5 && status_5 != 200 )
        {
            try {


                         nexusArtifactUploader  artifactId: "${artifactId}",
                           credentialsId: 'Nexus',
                           file: "target/${artifactId}-${version}-${BUILD_NUMBER}-dist.zip",
                           groupId: "com/stpl/igame",
                           nexusUrl: '192.168.126.99:8087',
                           nexusVersion: 'nexus3',
                           protocol: 'http',
                           repository: 'IGAME',
                           type: 'zip',
                           version: "${releaseVersion}"
  
     def response_5 = httpRequest  timeout: 30, url: "http://${NEXUS_BASE_URL}/repository/IGAME/com/stpl/igame/${artifactId}/${releaseVersion}/${artifactId}-${releaseVersion}.zip", validResponseCodes: '200'
                /*    echo "${NEXUS_BASE_URL}/repository/KhelPlayRummy/com/stpl/${artifactId}-${version}/${releaseVersion}/${artifactId}-${version}-${releaseVersion}.zip"*/
                    status_5 = response_5.status 
                                      
               }
            catch(Exception e  ){
            sleep(1)
               }
               }
              stage 'Deploying'
              slackSend color: "#439FE0", message: "Build Number:${BUILD_NUMBER} Deployment Started For: ${BRANCH_NAME} For Weaver",  teamDomain: 'skilrock', token: 'PJZoglka3a5W4T6fZUfLwWfE'
                echo 'Deploying'
       build job: 'WeaverTestJob', parameters: [string(name: 'target', value: "weaver"), string(name: 'NEXUS_URL', value: "${NEXUS_BASE_URL}"), string(name: 'RepoName', value: "IGAME"), string(name: 'GroupId_9', value: "${groupId}"), string(name: 'ArtifactId', value: "${artifactId}"), string(name: 'ReleaseVersion', value: "${releaseVersion}"), string(name: 'FileName', value: "${artifactId}-${releaseVersion}.zip"),string(name: 'versionBO_API', value: "2.0.2-SNAPSHOT")]
                
               }
               
               
               
               @NonCPS
def getPomValue(text, element) {
  def matcher = text =~ '<' + element + '>(.+)</' + element + '>'
  matcher ? matcher[0][1] : null
}

