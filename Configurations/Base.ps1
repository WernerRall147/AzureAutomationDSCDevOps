Function LinuxString($inputStr){
    $outputStr = $inputStr.Replace("`r`n","`n")
    $outputStr += "`n"
    Return $outputStr
 }

Configuration Base{
Import-DSCResource -Module nx

Node localhost {
$Contents = @'
search contoso.com
domain contoso.com
nameserver 10.185.85.11
'@
    $Contents = LinuxString $Contents

    nxFile resolvConf
    {
        DestinationPath = "/etc/resolv.conf"
        Mode = "644"
        Type = "file"
        Contents = $Contents
    }

    nxPackage chronyd
    {
        Name = "chronyd"
        Ensure = "Present"
        PackageManager = "Yum"
    }

    nxService chronyd 
    {
        Name = 'chronyd'
        State = 'running'
        Enabled = $true
        Controller = 'systemd'
    }

    nxScript timeConf {
        SetScript = @'
    #!/bin/bash
    sudo cp /usr/share/zoneinfo/Africa/Johannesburg /etc/localtime
    '@
        TestScript = @'
    #!/bin/bash
    timezone=`timedatectl status | grep "zone"`
    if [ $timezone -contains "Johannesburg"]
    then
        exit 0
    else
        exit 1
    fi
    '@
        GetScript = @'
    #!/bin/bash
    timedatectl status | grep "zone"
    '@
    }

}

}