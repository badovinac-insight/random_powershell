#$subscriptions = Get-AzManagementGroupSubscription -GroupName "PRODUCTION-MG"
$subscriptions = @('aa-ba-prod-spoke','aa-corp-prod-spoke','aa-dt-prod-spoke','aa-aot-prod-spoke','aa-ct-prod-spoke','aa-sales-spoke','aa-cstrm-prod-spoke')

# foreach ($s in $subscriptions){
#     $subs += Get-AzSubscription -SubscriptionName $s.DisplayName
# }


$cleanacr = New-Object System.Collections.ArrayList
foreach ($sub in $subscriptions) {
    Set-AzContext -Subscription $sub
    $acr = Get-AzContainerRegistry
    foreach ($reg in $acr) {
        #Write-Output $reg.Id
        $cleanacr.Add($reg.Id) > $null
    }
}

Write-Output "**********LIST OF ACR*******************"
$cleanacr #| Export-CSV -Path .\acrs.csv -NoTypeInformation