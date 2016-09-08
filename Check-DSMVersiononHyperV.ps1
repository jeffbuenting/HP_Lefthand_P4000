############################################################################### 
# Function: Test-RegSubKey 
# Description: Test the existence of the registry key 
# Return Value: True/false respectively 

function Test-RegSubKey{ 
    param( 
        [string]$server = ".", 
        [string]$hive, 
        [string]$keyName 
    ) 

    $hives = [enum]::getnames([Microsoft.Win32.RegistryHive]) 

    if($hives -notcontains $hive){ 
        write-error "Invalid hive value"; 
        return; 
    } 
    $regHive = [Microsoft.Win32.RegistryHive]$hive; 
    $regKey = [Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey($regHive,$server); 
    $subKey = $regKey.OpenSubKey($keyName); 

    if(!$subKey){$false}  else {$true} 
} 

#--------------------------------------------------------------------------------
# Main
#--------------------------------------------------------------------------------

Get-VMMServer VBAS0080 | out-Null

# ----- Get hosts in a specific Host Group
$VMHostGroup = Get-VMHostGroup -Name 'Production'

$Hosts = Get-VMHost -VMHostGroup $VMHostGroup

#[enum]::getnames([Microsoft.Win32.RegistryHive]) 

#"Servers running HP MPIO DSM 9.0.0.1030.1"
#
#foreach( $HVHost in $Hosts ) {
#	$H=$HVHost.Name
#	"Checking $H..."
#	if ( ( Test-RegSubKey $HVHost.Name  'LocalMachine' "SOFTWARE\Wow6432Node\HP\HP P4000 DSM for MPIO\9.0.0.1030.1" )   ) {
#			"     Installed"
#		}
#		else {
#			Write-Host -ForegroundColor Red "     Not Installed!"
#	}
#}


# ----- Search for DSM
"Servers running HP MPIO DSM 9.5.0.981.1"

foreach( $HVHost in $Hosts ) {
	$H=$HVHost.Name
	"Checking $H..."
	if ( ( Test-RegSubKey $HVHost.Name  'LocalMachine' "SOFTWARE\Wow6432Node\HP\HP P4000 DSM for MPIO\9.5.0.981.1" )   ) {
			"     Installed"
		}
		else {
			Write-Host -ForegroundColor Red "     Not Installed!"
	}
}