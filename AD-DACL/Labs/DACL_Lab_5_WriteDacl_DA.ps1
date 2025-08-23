# ===============================================
# Lab 5: Grant 'frank' WriteDACL on Domain Admins group
# ===============================================

Import-Module ActiveDirectory

# Get attacker user 'frank'
$attacker = Get-ADUser "frank"
$attackerSID = New-Object System.Security.Principal.SecurityIdentifier($attacker.SID)

# Get target group 'Domain Admins'
$target = Get-ADGroup "Domain Admins"
$targetDN = $target.DistinguishedName
$targetADSI = [ADSI]"LDAP://$targetDN"
$acl = $targetADSI.ObjectSecurity

# Clear existing ACEs for this user (optional cleanup)
$acl.Access | Where-Object { $_.IdentityReference -eq $attackerSID } | ForEach-Object {
    $acl.RemoveAccessRule($_)
}

# Add WriteDACL ACE (non-inheritable)
$ace = New-Object System.DirectoryServices.ActiveDirectoryAccessRule (
    $attackerSID,
    "WriteDacl",
    "Allow",
    [Guid]::Empty,
    "None"
)

$acl.AddAccessRule($ace)
$targetADSI.ObjectSecurity = $acl
$targetADSI.CommitChanges()

Write-Host "✅ 'frank' now has WriteDACL on Domain Admins" -ForegroundColor Green
