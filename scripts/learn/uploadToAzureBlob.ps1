<#
.SYNOPSIS
  Upload a file from the filesystem to an Azure Blob Storage.
.DESCRIPTION
  Simple script to upload a file to Azure Blob Storage.
  After the upload has completed, the blob URI will be printed.
.PARAMETER UploadFile
  The file to upload
.PARAMETER StorageContainer
  Name of the storage container to which we will upload the file
.PARAMETER StorageAccountName
  Name of the storage account where the storage container belongs
.PARAMETER StorageAccountKey
  Access key to the storage account. Can be obtained from the Azure Portal
.INPUTS
  None
.OUTPUTS
  None
.NOTES
  Version:        1.0
  Author:         Jacob B Poulsen
  Creation Date:  05-10-2017
  Purpose/Change: Initial script development
#>

#---------------------------------------------------------[Script Parameters]------------------------------------------------------

param(
    [Parameter(Mandatory=$true)][string]$UploadFile,
    [Parameter(Mandatory=$true)][string]$StorageContainer,
    [Parameter(Mandatory=$true)][string]$StorageAccountName,
    [Parameter(Mandatory=$true)][string]$StorageAccountKey
)
  
  #---------------------------------------------------------[Initialisations]--------------------------------------------------------
  
  #Set Error Action to Silently Continue
  $ErrorActionPreference = 'SilentlyContinue'
  
  #Import Modules & Snap-ins
  
  #----------------------------------------------------------[Declarations]----------------------------------------------------------
  
  #Any Global Declarations go here

$ctx = New-AzureStorageContext -StorageAccountName $StorageAccountName -StorageAccountKey $StorageAccountKey

  #-----------------------------------------------------------[Execution]------------------------------------------------------------

  # Add-AzureRMAccount

Write-Host -NoNewline "Uploading file" $uploadFile "to Azure Blob Storage" $StorageContainer

Set-AzureStorageBlobContent -File $uploadFile -Container $StorageContainer -Blob $uploadFile.Name -Context $ctx

Write-Host -NoNewline "Uri:" (Get-AzureStorageBlob -Blob $uploadFile.Name -Container $StorageContainer -Context $ctx).ICloudBlob.uri.AbsoluteUri