[CmdletBinding()]
Param(
   [Parameter(Mandatory=$True)]
    [string]$InstallPath,
   [Parameter(Mandatory=$False)]
    [bool]$SslCert,
   [Parameter(Mandatory=$False)]
    [bool]$DebugMode
)

Set-ExecutionPolicy Bypass -Scope Process

$host.UI.RawUI.WindowTitle = "Myrtille Configuration . . . PLEASE DO NOT CLOSE THIS WINDOW . . ."

try
{
    # enable IIS, WebSocket protocol, management console and tools
	Enable-WindowsOptionalFeature -NoRestart -Online -FeatureName IIS-WebServerRole, IIS-WebServer, IIS-CommonHttpFeatures, IIS-DefaultDocument, IIS-DirectoryBrowsing, IIS-HttpErrors, IIS-StaticContent, IIS-HttpRedirect, IIS-HealthAndDiagnostics, IIS-HttpLogging, IIS-Performance, IIS-HttpCompressionStatic, IIS-Security, IIS-RequestFiltering, IIS-ApplicationDevelopment, IIS-ISAPIExtensions, IIS-ISAPIFilter, IIS-WebSockets, IIS-ManagementConsole, IIS-ManagementScriptingTools
	Write-Output "Enabled IIS, WebSocket protocol, management console and tools`r`n"

	# enable .NET extensibility
	Enable-WindowsOptionalFeature -NoRestart -Online -FeatureName IIS-NetFxExtensibility45, IIS-ASPNET45 -All
	Write-Output "Enabled .NET extensibility`r`n"

    # enable WCF/HTTP activation
    Enable-WindowsOptionalFeature -NoRestart -Online -FeatureName WAS-WindowsActivationService, WAS-ProcessModel, WAS-ConfigurationAPI, WCF-HTTP-Activation45
	Write-Output "Enabled WCF/HTTP activation`r`n"

	# myrtille self-signed certificate
	if ($SslCert)
	{
		$Cert = Get-ChildItem -Path "Cert:\LocalMachine\My" | Where-Object { $_.FriendlyName -eq "Myrtille self-signed certificate" }
		if (!($Cert))
		{
			# create the certificate
			$Name = ([System.Net.Dns]::GetHostByName(($env:computerName))).Hostname
			$Cert = New-SelfSignedCertificate -CertStoreLocation "Cert:\LocalMachine\My" -DnsName $Name
			$Cert.FriendlyName = "Myrtille self-signed certificate"
			Write-Output "Created Myrtille self-signed certificate"
				
			# bind the certificate
			$Bind = Get-WebBinding -Name "Default Web Site" -Protocol "https"
			if (!($Bind))
			{
				New-WebBinding -Name "Default Web Site" -IPAddress * -Port 443 -Protocol "https"
				Write-Output "Created https binding on default web site"
				$Bind = Get-WebBinding -Name "Default Web Site" -Protocol "https"
			}
			$Bind.AddSslCertificate($Cert.GetCertHashString(), "my")
			Write-Output "Bound Myrtille self-signed certificate"
		}
		else
		{
			Write-Output "Myrtille self-signed certificate already exists"
		}
	}
	else
	{
		Write-Output "Skipped creation of Myrtille self-signed certificate"
	}

	Import-Module WebAdministration

	# myrtille application pool
	if (!(Test-Path "IIS:\AppPools\MyrtilleAppPool"))
	{
		New-WebAppPool -Name "MyrtilleAppPool"
		Set-ItemProperty -Path "IIS:\AppPools\MyrtilleAppPool" -Name "managedRuntimeVersion" -Value "v4.0"
		Set-ItemProperty -Path "IIS:\AppPools\MyrtilleAppPool" -Name "managedPipelineMode" -Value $False
		Set-ItemProperty -Path "IIS:\AppPools\MyrtilleAppPool" -Name "enable32BitAppOnWin64" -Value $False
		Set-ItemProperty -Path "IIS:\AppPools\MyrtilleAppPool" -Name "processModel.loadUserProfile" -Value $True
		Set-ItemProperty -Path "IIS:\AppPools\MyrtilleAppPool" -Name "recycling.periodicRestart.time" -Value 0.00:00:00
		Write-Output "Created Myrtille application pool"
	}
	else
	{
		Write-Output "Myrtille application pool already exists"
	}

	# myrtille web application
	if (!(Get-WebApplication -Site "CorepointHealth" -Name "Myrtille"))
	{
		New-WebApplication -Site "CorepointHealth" -Name "Remote" -PhysicalPath $InstallPath -ApplicationPool "MyrtilleAppPool"
		Set-ItemProperty -Path "IIS:\Sites\CorepointHealth\Remote" -Name "enabledProtocols" -Value "https"
		Write-Output "Created Myrtille web application, protocols enabled: http,https"
	}
	else
	{
		Write-Output "Myrtille web application already exists"
	}

	if ($DebugMode)
	{
		Read-Host "`r`nPress ENTER to continue..."
	}
}
catch
{
	Write-Output $_.Exception.Message

	if ($DebugMode)
	{
		Read-Host "`r`nPress ENTER to continue..."
	}

	exit 1
}