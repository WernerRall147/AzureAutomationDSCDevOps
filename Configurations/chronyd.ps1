Configuration chronyd{
    Import-DSCResource -Module nx
    
    Node localhost {

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
}
}