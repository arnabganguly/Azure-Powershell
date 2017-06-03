Login-AzureRmAccount
Get-AzureRmSubscription
$StorageAccountName = "agstorageaccount1"
$StorageAccountKey = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
$ctx = New-AzureStorageContext -StorageAccountName $StorageAccountName -StorageAccountKey $StorageAccountKey
$containername = "images"
New-AzureStorageContainer -Name $containername -Context $ctx -Permission Blob
$locafiledirectory = "C:\Users\Arnab Ganguly\Desktop\"
$blobname = "DSC_0085.jpg"
$localFile = $locafiledirectory + $blobname
Set-AzureStorageBlobContent -File $localFile -Container $containername -Blob $blobname -Context $ctx
Get-AzureStorageBlob -Container $containername -Context $ctx