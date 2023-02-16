Configuration dns {
Function LinuxString($inputStr){
    $outputStr = $inputStr.Replace("`r`n","`n")
    $outputStr += "`n"
    Return $outputStr
 }
 
 Import-DSCResource -Module nx
 
 Node $Node
 {
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
 }
}