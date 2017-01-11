#!/bin/sh

set -e

# change local mvn repository.
echo -e '<settings xmlns="http://maven.apache.org/SETTINGS/1.0.0"\n  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"\n  xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.0.0 https://maven.apache.org/xsd/settings-1.0.0.xsd">\n  <localRepository>/usr/src/mymaven/localrepo</localRepository>\n</settings>' > /root/.m2/settings.xml

# install third party libraries.
mvn install:install-file -DgroupId=javax.mail -DartifactId=mail -Dversion=1.3.2 -Dpackaging=jar -Dfile=../third-party-libraries/mail.jar
mvn install:install-file -DgroupId=com.oracle -DartifactId=oracle-jdbc15 -Dversion=11.2.0.1.0 -Dpackaging=jar -Dfile=../third-party-libraries/ojdbc5.jar

# build Atlassian JIRA
./build.sh

exec "$@"