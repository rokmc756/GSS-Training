## Preparing Build and CCF Client environment on Mac
- Install CloudFoudry CLI referring from https://github.com/cloudfoundry/cli/releases
- Install MySQL Client on Mac
~~~
brew install mysql
~~~
- Install CloudForundy MySQL Plugin
~~~
cf install-plugin -r "CF-Community" mysql-plugin
~~~
- Install JDK 1.8
 - Installing java -  https://java.com/en/download/help/mac_install.xml
  - If you did not install JDK version correcdtly, Follow the step descriabed at the link [1]
    - [1] How to uninstall java on Mac -  https://explainjava.com/uninstall-java-macos/

## Preparing MySQL environment on PCF
- Loging into https://login.sys.datamelange.com with dev-XX user
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

## Build application
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

## Deploying application onto PCF
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
  - cf env spring-music-13
~~~
$ cf env spring-music-13
Getting env variables for app spring-music-13 in org seoul-mysql / space workshop as dev-13...
OK

System-Provided:
{
 "VCAP_SERVICES": {
  "p.mysql": [
   {
    "binding_name": null,
    "credentials": {
     "hostname": "q-n3s3y1.q-g906.bosh",
     "jdbcUrl": "jdbc:mysql://q-n3s3y1.q-g906.bosh:3306/service_instance_db?user=8913a1dfec29468c9926f8b4581a1714\u0026password=jszgk0bqu4htnqod\u0026useSSL=false",
     "name": "service_instance_db",
     "password": "jszgk0bqu4htnqod",
     "port": 3306,
     "uri": "mysql://8913a1dfec29468c9926f8b4581a1714:jszgk0bqu4htnqod@q-n3s3y1.q-g906.bosh:3306/service_instance_db?reconnect=true",
     "username": "8913a1dfec29468c9926f8b4581a1714"
    },
    "instance_name": "dev-db-13",
    "label": "p.mysql",
    "name": "dev-db-13",
    "plan": "db-small",
    "provider": null,
    "syslog_drain_url": null,
    "tags": [
     "mysql"
    ],
    "volume_mounts": []
   }
  ]
 }
}

{
 "VCAP_APPLICATION": {
  "application_id": "a2f14048-7bec-4a14-a7d8-b1c7f268275d",
  "application_name": "spring-music-13",
  "application_uris": [
   "spring-music-13-noisy-springhare-gv.apps.datamelange.com"
  ],
  "application_version": "65cc506e-4157-4103-99e5-065253ee5575",
  "cf_api": "https://api.sys.datamelange.com",
  "limits": {
   "disk": 1024,
   "fds": 16384,
   "mem": 1024
  },
  "name": "spring-music-13",
  "organization_id": "8fb043c2-8acf-4f84-bd67-7f706c4c6792",
  "organization_name": "seoul-mysql",
  "process_id": "a2f14048-7bec-4a14-a7d8-b1c7f268275d",
  "process_type": "web",
  "space_id": "0c296e18-045f-4f3c-a8d7-6216f52b628a",
  "space_name": "workshop",
  "uris": [
   "spring-music-13-noisy-springhare-gv.apps.datamelange.com"
  ],
  "users": null,
  "version": "65cc506e-4157-4103-99e5-065253ee5575"
 }
}

No user-defined env variables have been set

No running env variables have been set

No staging env variables have been set
~~~
- The better way to fetch credentials for CLI login to service instances:
  - cf create-service-key dev-db-13 sk-03-01
~~~
$ cf create-service-key dev-db-13 sk-10-08
Creating service key sk-10-08 for service instance dev-db-13 as dev-13...
OK
~~~

## Connecting MySQL database 
- A cf CLI plugin provides access to service instances using an SSH tunnel:
  - cf mysql dev-db-13
~~~
$ cf mysql dev-db-13
mysql: [Warning] Using a password on the command line interface can be insecure.
Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 412
Server version: 5.7.26-29-log MySQL Community Server (GPL)

Copyright (c) 2000, 2019, Oracle and/or its affiliates. All rights reserved.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql>
~~~
- Using a similar approach, a developer is able to make a backup:
~~~
$ cf mysqldump dev-db-13 album --column-statistics=0 --set-gtid-purged=OFF > my-db-dump-$( date +%s ).sql
mysqldump: [Warning] Using a password on the command line interface can be insecure.`
~~~

- Work through example of data loading, index creation, viewing query plan, compressing a table. NOTE: you must have an app bound to the service instance before doing this.
- Create the tables: use ./osm_tables.sql, either copy/paste into a cf mysql terminal, or cf mysql dev-db-13 < ./osm_tables.sql
- Set your service instance name in the load script, ./load_osm_data_mysql.sh
- Run that script to load data into these tables: ./load_osm_data_mysql.sh Caveat: if you need to load large data sets, it's better to do that in smaller chunks, as discussed here.
- Run query:
~~~
select v, count(*) from osm_k_v where k = 'amenity' group by 1 order by 2 desc limit 30;
~~~
- Review query plan (e.g. EXPLAIN):
~~~
explain select v, count(*) from osm_k_v where k = 'amenity' group by 1 order by 2 desc limit 30;
~~~
- Create an index:
~~~
CREATE INDEX osm_k_idx ON osm_k_v(k);
~~~
- See how that index affects the query plan:
~~~
explain select v, count(*) from osm_k_v where k = 'amenity' group by 1 order by 2 desc limit 30;
~~~
- Re-run the query to see how the index affects its run time.
- Show how to compress the table:
~~~
-- Verify compression is working
mysql> CREATE TABLE osm_k_v_zlib
    -> (
    ->   id BIGINT
    ->   , k VARCHAR(64)
    ->   , v VARCHAR(512)
    ->   , FOREIGN KEY (id) REFERENCES osm(id) ON DELETE CASCADE
    -> ) ENGINE=INNODB, COMPRESSION="zlib";
Query OK, 0 rows affected (0.18 sec)

mysql> insert into osm_k_v_zlib select * from osm_k_v;
Query OK, 3032167 rows affected (19.25 sec)
Records: 3032167  Duplicates: 0  Warnings: 0

mysql> SELECT
    ->   table_name AS `Table`,
    ->   round(((data_length + index_length) / 1024 / 1024), 2) `Size in MB`
    -> FROM information_schema.TABLES
    -> WHERE
    ->   table_schema = "service_instance_db"
    ->   AND table_name = "osm_k_v";
+---------+------------+
| Table   | Size in MB |
+---------+------------+
| osm_k_v |     361.00 |
+---------+------------+
1 row in set (0.16 sec)

mysql> SELECT
    ->   table_name AS `Table`,
    ->   round(((data_length + index_length) / 1024 / 1024), 2) `Size in MB`
    -> FROM information_schema.TABLES
    -> WHERE
    ->   table_schema = "service_instance_db"
    ->   -- AND table_name = "osm_k_v";
    ->   AND table_name = "osm_k_v_zlib";
+--------------+------------+
| Table        | Size in MB |
+--------------+------------+
| osm_k_v_zlib |     240.34 |
+--------------+------------+
1 row in set (0.16 sec)
~~~
- RESULT: In this case, the compressed table is about 1/3 smaller than the original.
- Discuss table partitioning and show partition pruning.
- Create a very simple, partitioned, table:
~~~
DROP TABLE IF EXISTS members;
CREATE TABLE members
(
  id INT NOT NULL,
  firstname VARCHAR(25) NOT NULL,
  lastname VARCHAR(25) NOT NULL,
  username VARCHAR(16) NOT NULL,
  email VARCHAR(35),
  joined DATE NOT NULL,
  -- PRIMARY KEY (id) /* This won't work. */
  PRIMARY KEY (id, joined) /* The partition columns are required in the PK. */
)
PARTITION BY RANGE COLUMNS (joined)
(
    PARTITION p0 VALUES LESS THAN ('1960-01-01'),
    PARTITION p1 VALUES LESS THAN ('1970-01-01'),
    PARTITION p2 VALUES LESS THAN ('1980-01-01'),
    PARTITION p3 VALUES LESS THAN ('1990-01-01'),
    PARTITION p4 VALUES LESS THAN MAXVALUE
);
~~~
- Insert a row:
~~~
INSERT INTO members VALUES (1, 'Joe', 'Jones', 'jjones', 'jj@acme.com', '1986-07-19');
~~~
- Get the query plan for this query:
~~~
EXPLAIN SELECT * FROM members WHERE joined < '1989-01-01';
~~~
- Alter the predicate and see how the explain plan changes:
~~~
EXPLAIN SELECT * FROM members WHERE joined < '1989-01-01' AND joined > '1980-01-01';
~~~

## Reference commands
  - Destroy app
~~~
  cf delete spring-music-13
~~~
  - List app
~~~
  cf apps
~~~
  - List services
~~~
  cf services
~~~
  - Delete service
~~~
  cf delete-service dev-db-13
~~~
  - List buildpack
~~~
  cf buildpacks -B <build kind>
~~~
  - Unbind service
~~~
  cf us spring-music-13 dev-db-13
~~~
  - Create service key
~~~
  cf create-service-key dev-db-13 sk-10-08
~~~
  - Fetch credentials for CLI login to service instances:
~~~
  cf service-key dev-db-13 sk-10-08
~~~
  - Tunnel
~~~
  cf ssh -L 6336:q-m8779n3s0.q-g9014.bosh:3306 pivotal-mysqlweb
~~~
  - Find key and delete it
~~~
  cf service-keys dev-db-13
  Getting keys for service instance dev-db-13 as dev-13...
  name
  cf-mysql
~~~
  - Delete service key
~~~
  cf delete-service-key dev-db-13 cf-mysql
  Really delete the service key cf-mysql?> y
  Deleting key cf-mysql for service instance dev-db-13 as dev-13...
  OK
  Delete in progress. Use 'cf services' or 'cf service dev-db-13' to check operation status.
~~~
  - How to check MySQL Engine type
~~~
  SELECT engine FROM information_schema.TABLES where table_name='wp_users' AND table_schema='zetawiki';
~~~
  - Alter engine for the table
~~~
  ALTER TABLE table_name ENGINE = InnoDB;
~~~
