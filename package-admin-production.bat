call mvn clean package -Dmaven.test.skip=true -Pprod
copy .\target\ROOT.war
@echo on
echo 'Build project successfully!'