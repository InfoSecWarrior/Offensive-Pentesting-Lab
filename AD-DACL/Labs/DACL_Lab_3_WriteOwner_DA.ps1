# ===============================================
# Lab 3: Grant 'charlie' the WriteOwner permission on 'Domain Admins' group
# ===============================================

Import-Module ActiveDirectory

# Target group and user
$group = Get-ADGroup "Domain Admins"
$groupDN = $group.DistinguishedName

$user = Get-ADUser "charlie"
$userSID = New-Object System.Security.Principal.SecurityIdentifier($user.SID)

# Load DirectoryEntry
$groupDE = [ADSI]"LDAP://$groupDN"
$acl = $groupDE.ObjectSecurity

# Define the ACE with WriteOwner
$ace = New-Object System.DirectoryServices.ActiveDirectoryAccessRule(
    $userSID,
    "WriteOwner",
    "Allow"
)

# Apply and commit
$acl.AddAccessRule($ace)
$groupDE.ObjectSecurity = $acl
$groupDE.CommitChanges()

Write-Host "✅ 'charlie' now has WriteOwner on Domain Admins group." -ForegroundColor Green
