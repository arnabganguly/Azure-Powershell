# Login to the Azure subscription
Login-AzureRmAccount
Get-AzureRmSubscription

# Create the Resourcegroup 
$rgname = ag532
New-AzureRmResourceGroup -Name $rgname -Location "West US" 

# Create the Subnet and Vnet
$subnetconfig = New-AzureRmVirtualNetworkSubnetConfig -Name subnet1 -AddressPrefix 10.0.1.0/24 
$vnetconfig = New-AzureRmVirtualNetwork -Name vnet1 -ResourceGroupName ag532 -Location "West US" -AddressPrefix 10.0.0.0/16 -Subnet $subnetconfig

# Create the Public IP Address
$pip = New-AzureRmPublicIpAddress -Name agip -ResourceGroupName ag532 -Location "West US" -AllocationMethod Static -IdleTimeoutInMinutes 4 

#Create the NSG Rules and the NSG 
# 1. Create the RDP Rule 
$nsgrulRDP = New-AzureRmNetworkSecurityRuleConfig -Name agnsgrdp -Protocol Tcp -Direction Inbound -SourceAddressPrefix * -DestinationAddressPrefix * -SourcePortRange * -DestinationPortRange 3389 -Access Allow -Priority 1000
# 2. Create the Web Rule
$nsgruleweb = New-AzureRmNetworkSecurityRuleConfig -Name agnsgweb -Protocol Tcp -Direction Inbound -SourceAddressPrefix * -DestinationAddressPrefix * -SourcePortRange * -DestinationPortRange 80 -Access Allow -Priority 1001
# 3. Create the NSG
$nsg = New-AzureRmNetworkSecurityGroup -Name agnsggroup -ResourceGroupName ag532 -Location "West US" -SecurityRules $nsgrulRDP,$nsgruleweb 

 # Assign NSG to the Nic card
$nic = New-AzureRmNetworkInterface -Name agnw -ResourceGroupName $rgname -Location "West US" -SubnetId $vnetconfig.Subnets[0].Id -PublicIpAddressId $pip.Id -NetworkSecurityGroupId $nsg.Id

# Create the VM Config
$cred = Get-Credential
$vmconfig =  New-AzureRmVMConfig -VMName agvm2 -VMSize Standard_DS2 | Set-AzureRmVMOperatingSystem -Windows -Credential $cred -ComputerName agvm2 | Set-AzureRmVMSourceImage -PublisherName MicrosoftWindowsServer -Offer WindowsServer -Skus 2016-Datacenter -Version latest | Add-AzureRmVMNetworkInterface -Id $nic.Id

# Create the VM 
New-AzureRmVM -ResourceGroupName $rgname -VM $vmconfig -Location "West US"

# Get the Public IP address of the VM for RDP Operations 
Get-AzureRmPublicIpAddress -ResourceGroupName $rgname | Select IpAddress

# Finally Remove the resource group and all its resources 
Remove-AzureRmResourceGroup -Name $rgname


