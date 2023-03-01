Configuration centOsRepoManager{
    Import-DSCResource -Module nx
    
Node localhost {

$testScript = @'
#!/bin/bash
katelloold=rpm -qa |grep katello-ca-consumer`
if [ $katelloold -eq $null]
then
    exit 0
else
    exit 1
fi
'@

$setScript = @'
#!/bin/bash
rpm -e `rpm -qa | grep katello-ca-consumer`
'@

$getScript = @'
#!/bin/bash
rpm -qa |grep katello-ca-consumer
'@

    nxScript centOsRepoManager {
        SetScript = $setScript
        TestScript = $testScript
        GetScript = $getScript
        }

    nxPackage kattelo-ca {
        Name = "kattelo-ca"
        Ensure = "Present"
        PackageManager = "RPM"
        }
    
    
    
    
    }
}