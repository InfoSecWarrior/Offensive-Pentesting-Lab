# ===============================================
# Lab 2: Grant 'bob' AddSelf on Backup Operators group
# ===============================================

Import-Module ActiveDirectory

# Get target user and group
$user = Get-ADUser "bob"
$group = Get-ADGroup "Backup Operators"
$userSID = New-Object System.Security.Principal.SecurityIdentifier($user.SID)
$groupDN = $group.DistinguishedName

# ADSI bind
$groupDE = [ADSI]"LDAP://$groupDN"
$acl = $groupDE.ObjectSecurity

# -- KEY FIX: Use 'AddSelf' from ActiveDirectoryRights enum --
$ace = New-Object System.DirectoryServices.ActiveDirectoryAccessRule(
    $userSID,
    [System.DirectoryServices.ActiveDirectoryRights]::Self,
    [System.Security.AccessControl.AccessControlType]::Allow
)

# Add ACE and apply
$acl.AddAccessRule($ace)
$groupDE.ObjectSecurity = $acl
$groupDE.CommitChanges()

Write-Host "✅ bob now has AddSelf on Backup Operators" -ForegroundColor Green 
