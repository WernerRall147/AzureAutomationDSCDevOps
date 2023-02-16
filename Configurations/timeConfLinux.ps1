Configuration timeConf{
Import-DSCResource -Module nx

Node localhost {
$testScript = @'
#!/bin/bash
timezone=`timedatectl status | grep "zone"`
if [ $timezone -contains "Johannesburg"]
then
    exit 0
else
    exit 1
fi
'@

$setScript = @'
#!/bin/bash
sudo cp /usr/share/zoneinfo/Africa/Johannesburg /etc/localtime
'@

$getScript = @'
#!/bin/bash
timedatectl status | grep "zone"
'@

    nxScript timeConf {
        SetScript = $setScript
        TestScript = $testScript
        GetScript = $getScript
        }
    }
}