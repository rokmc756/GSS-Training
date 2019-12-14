
- Loging into https://login.sys.datamelange.com with dev-XX
- Select MarketPlace and search MySQL for Pivotal Cloud Foundry v2 with keyword "mysql" and then select plan
- Specify Instance Name with dev-db-XX and click Create button. It will take a few minutes
- Create service after login with cf cli on Mac
~~~
$ cf login -a https://api.sys.datamelange.com --skip-ssl-validation
API endpoint: https://api.sys.datamelange.com

Email: dev-13

Password:
Authenticating...
OK

Targeted org seoul-mysql

Targeted space workshop

API endpoint:   https://api.sys.datamelange.com (API version: 3.74.0)
User:           dev-13
Org:            seoul-mysql
Space:          workshop
~~~
  - cf create-service p.mysql db-small dev-db-13
  - In these steps, the -03 is present to differentiate one student from another; use your assigned ID here in place of the 03
~~~
cf create-service p.mysql db-small dev-db-13
Creating service instance dev-db-13 in org seoul-mysql / space workshop as dev-13...
OK

Create in progress. Use 'cf services' or 'cf service dev-db-13' to check operation status.
~~~

- Install CloudFoudry CLI referring from https://github.com/cloudfoundry/cli/releases
- Install MySQL Client on Mac
  - brew install mysql
- Install CloudForundy MySQL Plugin
  - cf install-plugin -r "CF-Community" mysql-plugin
- Install JDK 1.8
 - Installing java -  https://java.com/en/download/help/mac_install.xml
  - If you did not install JDK version correcdtly, Follow the step descriabed at the link [1]
  - [1] How to uninstall java on Mac -  https://explainjava.com/uninstall-java-macos/


- Download the Zip file containing the Spring Music app from https://github.com/cloudfoundry-samples/spring-music, then unzip the downloaded file.
  - Change into the resulting directory
  - Edit the ./manifest.yml file, appending your team ID to the name value; e.g. name: spring-music-13
  - Build the Spring Boot app: ./gradlew clean build
~~~
$ ./gradlew clean build
Starting a Gradle Daemon (subsequent builds will be faster)

> Task :compileJava
Note: /Users/admin/gss-training-mysql-for-pcf/spring-music-master/src/main/java/org/cloudfoundry/samples/music/config/SpringApplicationContextInitializer.java uses or overrides a deprecated API.
Note: Recompile with -Xlint:deprecation for details.

> Task :test
2019-12-14 13:38:24.210  INFO 793 --- [       Thread-5] o.s.s.concurrent.ThreadPoolTaskExecutor  : Shutting down ExecutorService 'applicationTaskExecutor'
2019-12-14 13:38:24.215  INFO 793 --- [       Thread-5] j.LocalContainerEntityManagerFactoryBean : Closing JPA EntityManagerFactory for persistence unit 'default'
2019-12-14 13:38:24.216  INFO 793 --- [       Thread-5] .SchemaDropperImpl$DelayedDropActionImpl : HHH000477: Starting delayed evictData of schema as part of SessionFactory shut-down'
2019-12-14 13:38:24.223  INFO 793 --- [       Thread-5] com.zaxxer.hikari.HikariDataSource       : HikariPool-1 - Shutdown initiated...
2019-12-14 13:38:24.227  INFO 793 --- [       Thread-5] com.zaxxer.hikari.HikariDataSource       : HikariPool-1 - Shutdown completed.

BUILD SUCCESSFUL in 24s
~~~
- Deploy apps into PAS without starting
  - cf push --no-start
~~~
Pushing from manifest to org seoul-mysql / space workshop as dev-13...
Using manifest file /Users/admin/gss-training-mysql-for-pcf/spring-music-master/manifest.yml
Getting app info...
Creating app with these attributes...
+ name:       spring-music-13
  path:       /Users/admin/gss-training-mysql-for-pcf/spring-music-master/build/libs/spring-music-master-1.0.jar
+ memory:     1G
  routes:
+   spring-music-13-noisy-springhare-gv.apps.datamelange.com

Creating app spring-music-13...
Mapping routes...
Comparing local files to remote cache...
Packaging files to upload...
Uploading files...
 512.93 KiB / 512.93 KiB [=================================================================] 100.00% 4s

Waiting for API to complete processing files...

name:              spring-music-13
requested state:   stopped
routes:            spring-music-13-noisy-springhare-gv.apps.datamelange.com
last uploaded:
stack:
buildpacks:

type:           web
instances:      0/1
memory usage:   1024M
     state   since                  cpu    memory   disk     details
#0   down    2019-12-14T04:44:15Z   0.0%   0 of 0   0 of 0
~~~
- How do apps access services?
  - cf bind-service spring-music-13 dev-db-13
~~~
$ cf bind-service spring-music-13 dev-db-13
Binding service dev-db-13 to app spring-music-13 in org seoul-mysql / space workshop as dev-13...
OK

TIP: Use 'cf restage spring-music-13' to ensure your env variable changes take effect
~~~
  - cf start spring-music-13
~~~
$ cf bind-service spring-music-13 dev-db-13
Binding service dev-db-13 to app spring-music-13 in org seoul-mysql / space workshop as dev-13...
OK

TIP: Use 'cf restage spring-music-13' to ensure your env variable changes take effect
Admins-MacBook-Air-2:spring-music-master admin$ cf start spring-music-13
Starting app spring-music-13 in org seoul-mysql / space workshop as dev-13...

Staging app and tracing logs...
   Downloading binary_buildpack...
   Downloading r_buildpack...
   Downloading nginx_buildpack...
   Downloading php_buildpack...
   Downloading python_buildpack...
   Downloaded binary_buildpack
   Downloading dotnet_core_buildpack...
   Downloaded nginx_buildpack
   Downloading java_buildpack_offline...
   Downloaded python_buildpack
   Downloading staticfile_buildpack...
   Downloaded r_buildpack
   Downloading ruby_buildpack...
   Downloaded php_buildpack
   Downloading nodejs_buildpack...
   Downloaded dotnet_core_buildpack
   Downloading go_buildpack...
   Downloaded nodejs_buildpack
   Downloaded staticfile_buildpack
   Downloaded java_buildpack_offline
   Downloaded go_buildpack
   Downloaded ruby_buildpack
   Cell b0ef6c53-978f-4caa-b241-35d649f75715 creating container for instance 82139033-b405-4ae5-af7f-1d14b8a314cc
   Cell b0ef6c53-978f-4caa-b241-35d649f75715 successfully created container for instance 82139033-b405-4ae5-af7f-1d14b8a314cc
   Downloading app package...
   Downloaded app package (47.9M)
   -----> Java Buildpack v4.21 (offline) | https://github.com/cloudfoundry/java-buildpack.git#0bc7378
   -----> Downloading Jvmkill Agent 1.16.0_RELEASE from https://java-buildpack.cloudfoundry.org/jvmkill/bionic/x86_64/jvmkill-1.16.0-RELEASE.so (found in cache)
   -----> Downloading Open Jdk JRE 1.8.0_222 from https://java-buildpack.cloudfoundry.org/openjdk/bionic/x86_64/openjdk-jre-1.8.0_222-bionic.tar.gz (found in cache)
          Expanding Open Jdk JRE to .java-buildpack/open_jdk_jre (0.8s)
          JVM DNS caching disabled in lieu of BOSH DNS caching
   -----> Downloading Open JDK Like Memory Calculator 3.13.0_RELEASE from https://java-buildpack.cloudfoundry.org/memory-calculator/bionic/x86_64/memory-calculator-3.13.0-RELEASE.tar.gz (found in cache)
          Loaded Classes: 19609, Threads: 250
   -----> Downloading Client Certificate Mapper 1.11.0_RELEASE from https://java-buildpack.cloudfoundry.org/client-certificate-mapper/client-certificate-mapper-1.11.0-RELEASE.jar (found in cache)
   -----> Downloading Container Security Provider 1.16.0_RELEASE from https://java-buildpack.cloudfoundry.org/container-security-provider/container-security-provider-1.16.0-RELEASE.jar (found in cache)
   -----> Downloading Metric Writer 3.1.0_RELEASE from https://java-buildpack.cloudfoundry.org/metric-writer/metric-writer-3.1.0-RELEASE.jar (found in cache)
   -----> Downloading Spring Auto Reconfiguration 2.8.0_RELEASE from https://java-buildpack.cloudfoundry.org/auto-reconfiguration/auto-reconfiguration-2.8.0-RELEASE.jar (found in cache)
   Exit status 0
   Uploading droplet, build artifacts cache...
   Uploading droplet...
   Uploading build artifacts cache...
   Uploaded build artifacts cache (132B)
   Uploaded droplet (91.5M)
   Uploading complete
   Cell b0ef6c53-978f-4caa-b241-35d649f75715 stopping instance 82139033-b405-4ae5-af7f-1d14b8a314cc
   Cell b0ef6c53-978f-4caa-b241-35d649f75715 destroying container for instance 82139033-b405-4ae5-af7f-1d14b8a314cc
   Cell b0ef6c53-978f-4caa-b241-35d649f75715 successfully destroyed container for instance 82139033-b405-4ae5-af7f-1d14b8a314cc

Waiting for app to start...

name:              spring-music-13
requested state:   started
routes:            spring-music-13-noisy-springhare-gv.apps.datamelange.com
last uploaded:     Sat 14 Dec 13:48:02 KST 2019
stack:             cflinuxfs3
buildpacks:        client-certificate-mapper=1.11.0_RELEASE container-security-provider=1.16.0_RELEASE
                   java-buildpack=v4.21-offline-https://github.com/cloudfoundry/java-buildpack.git#0bc7378
                   java-main java-opts java-security jvmkill-agent=1.16.0_RELEASE metric-w...

type:            web
instances:       1/1
memory usage:    1024M
start command:   JAVA_OPTS="-agentpath:$PWD/.java-buildpack/open_jdk_jre/bin/jvmkill-1.16.0_RELEASE=printHeapHistogram=1
                 -Djava.io.tmpdir=$TMPDIR -XX:ActiveProcessorCount=$(nproc)
                 -Djava.ext.dirs=$PWD/.java-buildpack/container_security_provider:$PWD/.java-buildpack/open_jdk_jre/lib/ext
                 -Djava.security.properties=$PWD/.java-buildpack/java_security/java.security $JAVA_OPTS" &&
                 CALCULATED_MEMORY=$($PWD/.java-buildpack/open_jdk_jre/bin/java-buildpack-memory-calculator-3.13.0_RELEASE
                 -totMemory=$MEMORY_LIMIT -loadedClasses=20919 -poolType=metaspace -stackThreads=250
                 -vmOptions="$JAVA_OPTS") && echo JVM Memory Configuration: $CALCULATED_MEMORY &&
                 JAVA_OPTS="$JAVA_OPTS $CALCULATED_MEMORY" && MALLOC_ARENA_MAX=2 SERVER_PORT=$PORT eval exec
                 $PWD/.java-buildpack/open_jdk_jre/bin/java $JAVA_OPTS -cp $PWD/.
                 org.springframework.boot.loader.JarLauncher
     state     since                  cpu    memory        disk       details
#0   running   2019-12-14T04:48:29Z   0.0%   42.7K of 1G   8K of 1G
~~~
- Access the credentials for the bound service instance:
  - cf env spring-music-03
- The better way to fetch credentials for CLI login to service instances:
  - cf create-service-key dev-db-03 sk-03-01
- A cf CLI plugin provides access to service instances using an SSH tunnel:
  - cf mysql dev-db-03





- Destroy app
  - cf delete spring-music-13

- List app
  - cf apps

- List services
  - cf services
- Delete service
  - cf delete-service dev-db-03

- List buildpack
  - cf buildpacs -B <build kind>

- Unbind service
  - cf us spring-music-13 dev-db-13
  

- Create service key
 - cf create-service-key dev-db-13 sk-10-08

- Fetch credentials for CLI login to service instances:
 - cf service-key dev-db-13 sk-10-08

- Tunnel
  - cf ssh -L 6336:q-m8779n3s0.q-g9014.bosh:3306 pivotal-mysqlweb

- Find key and delete it
$ cf service-keys dev-db-13
Getting keys for service instance dev-db-13 as dev-13...

name
cf-mysql
Admins-MacBook-Air-2:spring-music-master-working-by-jomoon admin$ cf dsk dev-db-13 cf-mysql

Really delete the service key cf-mysql?> y
Deleting key cf-mysql for service instance dev-db-13 as dev-13...
OK

- Delete service
$ cf ds dev-db-13

Really delete the service dev-db-13?> y
Deleting service dev-db-13 in org seoul-mysql / space workshop as dev-13...
OK

Delete in progress. Use 'cf services' or 'cf service dev-db-13' to check operation status.

- How to check MySQL Engine type
$ SELECT engine FROM information_schema.TABLES where table_name='wp_users' AND table_schema='zetawiki';

ALTER TABLE table_name ENGINE = InnoDB;
