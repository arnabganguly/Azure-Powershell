﻿Login-AzureRmAccount
$rule1 = New-AzureRmNetworkSecurityRuleConfig -Name rdprule1 -Description "Allow RDP" -Access Allow -Protocol Tcp -Direction Inbound -Priority 100 -SourceAddressPrefix Internet -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange 3389
$rule2 = New-AzureRmNetworkSecurityRuleConfig -Name httprule1 -Description "Allow HTTP" -Access Allow -Protocol Tcp -Direction Inbound -Priority 101 -SourceAddressPrefix Internet -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange 80
$nsg = New-AzureRmNetworkSecurityGroup -Name agnsg3 -ResourceGroupName agrg -Location westus -SecurityRules $rule1,$rule2
