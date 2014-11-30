#!/bin/bash 

# give the newly provisioned system some time to settle down
echo "Sleeping..."
sleep 30

# setup folder, permissions
cd /var/www
sudo chmod -R 777 .

# run tests
echo "Running test..."
pylint -f parseable project/ > pylint.out
nosetests --with-xcoverage --with-xunit --all-modules --traverse-namespace --cover-package=project --cover-inclusive --cover-erase -x tests.py;
clonedigger --cpd-output -o clonedigger.xml project
sloccount --duplicates --wide --details . | fgrep -v .svn > sloccount.sc || :
echo "Tests finished..."

# copy over test results
echo "Copying test results to Jenkins..."
TEST_FOLDER="vagrant@192.168.1.2:/var/lib/jenkins/jobs/discover-flask-vagrant/workspace/"
export TEST_FOLDER
sshpass -p "vagrant" scp -oStrictHostKeyChecking=no pylint.out $TEST_FOLDER
sshpass -p "vagrant" scp -oStrictHostKeyChecking=no nosetests.xml $TEST_FOLDER
sshpass -p "vagrant" scp -oStrictHostKeyChecking=no coverage.xml $TEST_FOLDER
sshpass -p "vagrant" scp -oStrictHostKeyChecking=no clonedigger.xml $TEST_FOLDER
sshpass -p "vagrant" scp -oStrictHostKeyChecking=no sloccount.sc $TEST_FOLDER
echo "Tests copied over to Jenkins..."
exit