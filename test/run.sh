cd $(dirname $0)
pwd
ls -l
cd ..
pwd
ls -l
echo "*******************************************"
echo "*                                         *"
echo "*    install of Maven noraui-archetype    *"
echo "*                                         *"
echo "*******************************************"
mvn clean install

mkdir generate_app
cd generate_app
echo "************************************************"
echo "*                                              *"
echo "*    generate a robot from noraui-archetype    *"
echo "*                                              *"
echo "************************************************"
mvn archetype:generate -DarchetypeGroupId=com.github.noraui -DarchetypeArtifactId=noraui-archetype -DarchetypeVersion=3.0.0 -DgroupId=com.your.company -DartifactId=robot -DinteractiveMode=false

pwd
ls -l
cd robot
echo "**********************************************************"
echo "*                                                        *"
echo "*    run and test robot generated by noraui-archetype    *"
echo "*                                                        *"
echo "**********************************************************"
mvn clean test javadoc:javadoc -Dcucumber.options="--tags '@LoginLogout'" -Pjavadoc,preIC,scenarioInitiator,ci,unit-tests,postIC -Dmaven.test.failure.ignore=true

curl -s "https://api.travis-ci.org/jobs/${TRAVIS_JOB_ID}/log.txt?deansi=true" > nonaui.log

counters1=$(sed -n 's:.*<EXPECTED_RESULTS_1>\(.*\)</EXPECTED_RESULTS_1>.*:\1:p' nonaui.log | head -n 1)
nb_counters2=$(sed -n ":;s/$counters1//p;t" nonaui.log | sed -n '$=')

counters2=$(sed -n 's:.*<EXPECTED_RESULTS_2>\(.*\)</EXPECTED_RESULTS_2>.*:\1:p' nonaui.log | head -n 1)
nb_counters2=$(sed -n ":;s/$counters2//p;t" nonaui.log | sed -n '$=')

# check if BUILD FAILURE finded in logs
nb_failure=$(sed -n ":;s/BUILD FAILURE//p;t" nonaui.log | sed -n '$=')
if [ "$nb_failure" != "" ]; then
    echo "******** BUILD FAILURE find $nb_failure time in build"
    exit 255
fi

# 2 = 1 (real) + 1 counter (Excel)
if [ "$nb_counters1" == "2" ]; then
    echo "******** All counter is SUCCESS"
else
    echo "******** All counter is FAIL"
    exit 255
fi
if [ "$nb_counters2" == "2" ]; then
    echo "******** All counter is SUCCESS"
else
    echo "******** All counter is FAIL"
    exit 255
fi

exit 0
