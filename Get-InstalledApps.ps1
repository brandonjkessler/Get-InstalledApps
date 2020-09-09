Param(
			[Parameter(Position=0,Mandatory=$true,ParameterSetName='singleapp')][String]$App,
			[Parameter(Mandatory=$true)][ValidateSet('32','64','all')][string]$Arch
		)

## Create Arry of Applications
if($Arch -eq 32 ){
	[Array]$Apps32 = @()
	$Apps32 += Get-ItemProperty 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*' | Where-Object{$_.DisplayName -like "*$App*"} # 32 Bit
	Return $Apps32
} elseif($Arch -eq 64){
	[Array]$Apps64 = @()
	$Apps64 += Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*' | Where-Object{$_.DisplayName -like "*$App*"} # 64 Bit
	Return $Apps64
} elseif {
	[Array]$AppsAll = @()
	$AppsAll += Get-ItemProperty 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*' | Where-Object{$_.DisplayName -like "*$App*"} # 32 Bit
	$AppsAll += Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*' | Where-Object{$_.DisplayName -like "*$App*"} # 64 Bit
	Return $AppsAll
}
