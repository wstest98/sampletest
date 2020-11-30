#!/bin/sh

## PROJECT NAME ##
export oldPrjName=PROJECT9
export newPrjName=$1

## SERVICE NAME ##
export oldAppName=APPLE9
export newAppName=$2

### CHECK INPUT DATA ##
if [ e$newAppName == "e" ];
then
        echo " input PROJECT Info ....."
        echo " ex ) ./postinstall.sh \"New Project Name\" \"New Service Name\" "
        exit 1
fi

cp default-template.yaml ${newPrjName}-${newAppName}-eap72-template.yaml
cp default-volume.yaml ${newPrjName}-${newAppName}-eap72-volume.yaml

### create template ##
sed -i "s/${oldPrjName}/${newPrjName}/g" ./${newPrjName}-${newAppName}-eap72-*.yaml
sed -i "s/${oldAppName}/${newAppName}/g" ./${newPrjName}-${newAppName}-eap72-*.yaml

echo "#### SERVICE : $newAppName ####"
grep ${newAppName} ./${newPrjName}-${newAppName}-eap72-template.yaml

### create volume LOG,DATA ##
function new_vol() {
mkdir -p /mnt/openshift/${newPrjName}/${newAppName}-eap/{log,data}
chown -R nfsnobody.nfsnobody /mnt/openshift/${newPrjName}
chmod -R 777 /mnt/openshift/${newPrjName}

echo "#### PV PATH ####"
ls -alR /mnt/openshift/${newPrjName}

oc login -u system:admin
oc create -f ${newPrjName}-${newAppName}-eap72-template.yaml
oc create -f ${newPrjName}-${newAppName}-eap72-volume.yaml

sleep 2
oc get pvc
}
new_vol

### Create Delete script ###
cat << EOF > ${newPrjName}-${newAppName}-delete.sh
oc delete -f ${newPrjName}-${newAppName}-eap72-template.yaml
oc delete -f ${newPrjName}-${newAppName}-eap72-volume.yaml
sleep 1

rm -rf  /mnt/openshift/${newPrjName}/${newAppName}-eap
ls -alR /mnt/openshift/${newPrjName}

oc get template ${newPrjName}-${newAppName}-eap
oc get pv | grep ${newPrjName}-${newAppName}
oc get pvc -n ${newPrjName} | grep ${newPrjName}-${newAppName}
EOF

chmod +x ./${newPrjName}-${newAppName}-delete.sh

