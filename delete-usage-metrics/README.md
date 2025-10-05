# Delete Usage Metrics Datasets

PowerShell script for managing and deleting Power BI usage metrics datasets from a workspace.

## Description

This script connects to Power BI Service (US Government environment), adds the user as an admin to a specified workspace, identifies usage metrics datasets, and provides the option to delete them.

## Requirements

- PowerShell
- Power BI PowerShell cmdlets
- Appropriate permissions in Power BI Service

## Usage

```powershell
.\Delete-Usage-Metrics-datasets.ps1 -workspaceName "YourWorkspaceName" -userPrincipalName "your.email@domain.com"
```

## Parameters

- `workspaceName` (required): The name of the Power BI workspace
- `userPrincipalName` (required): The user's email address/UPN for admin access

## What it does

1. Logs into Power BI Service (US Government environment)
2. Retrieves the specified workspace
3. Adds the user as an admin to the workspace
4. Lists all usage metrics datasets in the workspace
5. Prompts for confirmation before deletion
6. Deletes the confirmed datasets
7. Removes the user as admin from the workspace
