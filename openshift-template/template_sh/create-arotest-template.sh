#!/bin/sh

## PROJECT NAME ##
export oldPrjName=PROJECT9
export newPrjName=$1

## SERVICE NAME ##
export oldAppName=APPLE9
export newAppName=$2

## STORAGE PATH ## 
export STORAGE_PATH="/storage/nfs/application-pv"

### CHECK INPUT DATA ##
if [ e$newAppName == "e" ];
then
        echo " input PROJECT Info ....."
        echo " ex ) ./postinstall.sh \"New Project Name\" \"New Service Name\" "
        exit 1
fi

cp ./default/default-tomcat8-template.yaml ${newPrjName}-${newAppName}-tomcat8-template.yaml
#cp ./default/default-tomcat8-volume.yaml ${newPrjName}-${newAppName}-tomcat8-volume.yaml

### create template ##
sed -i "s/${oldPrjName}/${newPrjName}/g" ./${newPrjName}-${newAppName}-tomcat8-*.yaml
sed -i "s/${oldAppName}/${newAppName}/g" ./${newPrjName}-${newAppName}-tomcat8-*.yaml

echo "#### SERVICE : $newAppName ####"
grep ${newAppName} ./${newPrjName}-${newAppName}-tomcat8-template.yaml

### create volume LOG,DATA ##
function new_vol() {
mkdir -p ${STORAGE_PATH}/${newPrjName}/${newAppName}-tomcat8/{log,data}
chown -R nfsnobody.nfsnobody /storage/nfs/application-pv/${newPrjName}
chmod -R 777 /storage/nfs/application-pv/${newPrjName}

echo "#### PV PATH ####"
ls -alR ${STORAGE_PATH}/${newPrjName}

#oc login -u system:admin
oc create -f ${newPrjName}-${newAppName}-tomcat8-template.yaml
#oc create -f ${newPrjName}-${newAppName}-tomcat8-volume.yaml

sleep 2
#oc get pvc
}
#new_vol

### Create Delete script ###
#cat << EOF > ${newPrjName}-${newAppName}-delete.sh
#oc delete -f ${newPrjName}-${newAppName}-tomcat8-template.yaml
#oc delete -f ${newPrjName}-${newAppName}-tomcat8-volume.yaml
#sleep 1
#
#rm -rf  /storage/nfs/application-pv/${newPrjName}/${newAppName}-tomcat8
#ls -alR /storage/nfs/application-pv/${newPrjName}
#
#oc get template ${newPrjName}-${newAppName}-tomcat8
#oc get pv | grep ${newPrjName}-${newAppName}
#oc get pvc -n ${newPrjName} | grep ${newPrjName}-${newAppName}
#EOF
#
#chmod +x ./${newPrjName}-${newAppName}-delete.sh
#
