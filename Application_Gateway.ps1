Login-AzureRmAccount

* Create a new subnet
$subnet = New-AzureRmVirtualNetworkSubnetConfig -Name agsubnetps -AddressPrefix 10.0.4.0/24 
$vnet = New-AzureRmVirtualNetwork -Name agvmps -ResourceGroupName agrg -Location "West Central US" -AddressPrefix 10.0.0.0/16 -Subnet $subnet
$subnet = $vnet.Subnets[0]

$publicip = New-AzureRmPublicIpAddress -Name appipps -ResourceGroupName agrg -Location "West Central US" -AllocationMethod Dynamic

# Create the application gateway IP Configuration 
$gipconfig = New-AzureRmApplicationGatewayIPConfiguration -Name aggateway101 -subnet $subnet 

# Create backend IP address pool 
$pool = New-AzureRmApplicationGatewayBackendAddressPool -Name agapplicationpool -BackendIPAddresses 10.0.1.4,10.0.2.4

# Create the front end 