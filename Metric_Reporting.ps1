Login-AzureRmAccount
Get-AzureRmAlertRule -ResourceGroup agrg -DetailedOutput
$actionemail = New-AzureRmAlertRuleEmail -CustomEmails arnab.ganguly@hcl.com
$actionwebhook = New-AzureRmAlertRuleWebhook -ServiceUri https://www.contoso.com?token=mytoken

Add-AzureRmMetricAlertRule -Name PSmonitoringrule -Location "West US" -ResourceGroup agrg -TargetResourceId /subscriptions/8da2f62c-3648-4ad5-9537-b7d8a1f166e5/resourceGroups/agrg/providers/Microsoft.Compute/virtualMachines/agwebvm -MetricName "Percentage CPU" -Operator GreaterThan -Threshold 60 -WindowSize 00:05:00 -TimeAggregationOperator Total -Actions $actionemail,$actionwebhook -Description "alert on website activity" 
Get-AzureRmAlertRule -ResourceGroup agrg -DetailedOutput