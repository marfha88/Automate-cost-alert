try {
    "Logging in to Azure..."
    Connect-AzAccount -Identity
}
catch {
    Write-Error -Message $_.Exception
    throw $_.Exception
}

$ProgressPreference = 'SilentlyContinue'; Invoke-WebRequest -Uri https://aka.ms/installazurecliwindows -OutFile .\AzureCLI.msi; Start-Process msiexec.exe -Wait -ArgumentList '/I AzureCLI.msi /quiet'; Remove-Item .\AzureCLI.msi

$ContainerName = 'bicep'

set-azcontext -Subscription eab82de3-9f21-4b09-b79a-32afe64f302c

# Connect-AzAccount
$Context = New-AzStorageContext -StorageAccountName "saautomatecostalert" -UseConnectedAccount

# Download first blob
Get-AzStorageBlob -Container $ContainerName -Context $Context |
  Select-Object -Property Name

$DLBlob1HT = @{
    Blob        = 'cost-anomaly-alert.bicep'
    Container   = $ContainerName
    Destination = '.\'
    Context     = $Context
  }
  Get-AzStorageBlobContent @DLBlob1HT


    az login --identity
    az deployment sub create --location westeurope --template-file ./cost-anomaly-alert.bicep
    


