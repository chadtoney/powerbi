# Define variables
$workspaceName = "OHRA_CEHRIS"
$userPrincipalName = "Chad.Toney@va.gov"

# Login to Power BI Service Account
Login-PowerBIServiceAccount -Environment USGov

# Get workspace by name
$workspace = Get-PowerBIWorkspace -Scope Organization -Name $workspaceName

# Store workspace ID in a variable
$workspaceId = $workspace.Id

# Add yourself as an admin for the workspace
Add-PowerBIWorkspaceUser -Scope Organization -Id $workspaceId -UserPrincipalName $userPrincipalName -AccessRight Admin

# Get all datasets in the workspace
$datasets = Get-PowerBIDataset -Scope Organization -WorkspaceId $workspaceId

# Filter datasets to find those that contain the name "usage metrics"
$usageMetricsDatasets = $datasets | Where-Object {$_.Name -like '*usage metrics*'}

# Display the names and IDs of the usage metrics datasets
Write-Output "Usage metrics datasets:"
$usageMetricsDatasets | Format-Table -Property Name, Id

# Prompt user to confirm if they want to delete the usage metrics datasets
$response = Read-Host "Do you want to delete these datasets? (y/n)"

if ($response -eq 'y') {
    # Delete usage metrics datasets and display the names and IDs of the deleted datasets
    Write-Output "Deleted usage metrics datasets:"
    foreach ($dataset in $usageMetricsDatasets) {
        Invoke-PowerBIRestMethod -Url "https://api.powerbigov.us/v1.0/myorg/datasets/$($dataset.Id)" -Method Delete
        Write-Output "Name: $($dataset.Name), ID: $($dataset.Id)"
    }
} else {
    Write-Output "No datasets were deleted."
}

# Remove yourself as an admin from the workspace
Remove-PowerBIWorkspaceUser -WorkspaceId $workspaceId -UserPrincipalName $userPrincipalName
