

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

- 

- Build app
~~~In these steps, the -03 is present to differentiate one student from another; use your assigned ID here in place of the 03


cd spring-music
gradle build
~~~

- Destroy app
  - cf delete spring-music-13

- Push app
  - cf push --no-start

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
