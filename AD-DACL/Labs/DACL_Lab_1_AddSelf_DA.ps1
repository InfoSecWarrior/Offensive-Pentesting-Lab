# ===============================================
# Lab 1: Grant AddSelf (Write Members) permission to user "alice" on Domain Admins group
# ===============================================

Import-Module ActiveDirectory

# Get target user and group
$user = Get-ADUser "alice"
$group = Get-ADGroup "Domain Admins"
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

Write-Host "✅ alice now has AddSelf on Domain Admins" -ForegroundColor Green
