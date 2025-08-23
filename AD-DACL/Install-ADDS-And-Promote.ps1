# -----------------------------------------------
# Install Active Directory Domain Services role
# -----------------------------------------------
Install-WindowsFeature AD-Domain-Services -IncludeManagementTools

# -----------------------------------------------
# Promote to Domain Controller (creates a new domain "armour.local")
# -----------------------------------------------
$domainName = "armour.local"
$dsrmPassword = (ConvertTo-SecureString "Password@123" -AsPlainText -Force)

Install-ADDSForest -DomainName $domainName `
    -SafeModeAdministratorPassword $dsrmPassword `
    -InstallDNS -Force

# System will automatically reboot after this command to complete DC promotion
