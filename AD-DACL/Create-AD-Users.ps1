# -----------------------------------------------
# Run this script AFTER domain controller is ready
# -----------------------------------------------

# Import Active Directory module
Import-Module ActiveDirectory

# Define 20 custom users
$users = @(
    @{Name="alice"; Password="Password@123"},
    @{Name="bob"; Password="Password@123"},
    @{Name="charlie"; Password="Password@123"},
    @{Name="david"; Password="Password@123"},
    @{Name="emma"; Password="Password@123"},
    @{Name="frank"; Password="Password@123"},
    @{Name="grace"; Password="Password@123"},
    @{Name="harry"; Password="Password@123"},
    @{Name="irene"; Password="Password@123"},
    @{Name="jack"; Password="Password@123"},
    @{Name="kate"; Password="Password@123"},
    @{Name="leo"; Password="Password@123"},
    @{Name="mia"; Password="Password@123"},
    @{Name="nina"; Password="Password@123"},
    @{Name="oscar"; Password="Password@123"},
    @{Name="peter"; Password="Password@123"},
    @{Name="quinn"; Password="Password@123"},
    @{Name="rose"; Password="Password@123"},
    @{Name="steve"; Password="Password@123"},
    @{Name="tina"; Password="Password@123"}
)

# Create users if they don't already exist
foreach ($u in $users) {
    if (-not (Get-ADUser -Filter "SamAccountName -eq '$($u.Name)'" -ErrorAction SilentlyContinue)) {
        New-ADUser -Name $u.Name -SamAccountName $u.Name `
            -AccountPassword (ConvertTo-SecureString $u.Password -AsPlainText -Force) `
            -Enabled $true
    }
}

Write-Host "AD Setup Complete. 20 Users Created." -ForegroundColor Green
