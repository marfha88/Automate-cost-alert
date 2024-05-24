try {
    "Logging in to Azure..."
    Connect-AzAccount -Identity
}
catch {
    Write-Error -Message $_.Exception
    throw $_.Exception
}

$ProgressPreference = 'SilentlyContinue'; Invoke-WebRequest -Uri https://aka.ms/installazurecliwindows -OutFile .\AzureCLI.msi; Start-Process msiexec.exe -Wait -ArgumentList '/I AzureCLI.msi /quiet'; Remove-Item .\AzureCLI.msi

$ContainerName = 'costalert'

set-azcontext -Subscription 1e5cbc27-c885-4f6c-b0a5-d208a6577309

# Connect-AzAccount
$Context = New-AzStorageContext -StorageAccountName "saautocostalert01" -UseConnectedAccount

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

  $DLBlob2HT = @{
    Blob        = 'main.bicep'
    Container   = $ContainerName
    Destination = '.\'
    Context     = $Context
  }
  Get-AzStorageBlobContent @DLBlob2HT


    az login --identity
    az deployment sub create --location westeurope --template-file ./cost-anomaly-alert.bicep
    


