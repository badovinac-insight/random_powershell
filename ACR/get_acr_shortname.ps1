$results = @()
$subscriptions = Get-AzSubscription

foreach ($sub in $subscriptions) {
    Set-AzContext -Subscription $sub.Name
    $acrs = Get-AzContainerRegistry
    foreach ($acr in $acrs) {
        if($acr.Tags.'aa-app-shortname' -ne $null){
            $results += New-Object PSObject -Property @{
                        ACR_Name = $acr.Name;
                        ShortName = $acr.Tags.'aa-app-shortname'
                    }
            Write-Output $acr.Name
        }
        else {
            Write-Output $acr.Name "has no shortname"
        }
    }
}
$results | Export-Csv -Path C:\RandomPowershell\ACR\acr_short2.csv -NoTypeInformation