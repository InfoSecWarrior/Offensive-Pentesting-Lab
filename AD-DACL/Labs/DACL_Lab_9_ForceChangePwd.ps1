# ===============================================
# Lab 9: Grant 'leo' ForceChangePassword (ResetPassword) on user 'mia'
# ===============================================

Import-Module ActiveDirectory

# Attacker
$attacker = Get-ADUser "leo"
$attackerSID = New-Object System.Security.Principal.SecurityIdentifier($attacker.SID)

# Victim
$target = Get-ADUser "mia"
$targetDN = $target.DistinguishedName
$targetADSI = [ADSI]"LDAP://$targetDN"
$acl = $targetADSI.ObjectSecurity

# Reset any previous ACEs (optional cleanup)
$acl.Access | Where-Object { $_.IdentityReference -eq $attackerSID } | ForEach-Object {
    $acl.RemoveAccessRule($_)
}

# GUID for Reset Password extended right
$resetPasswordGUID = [GUID]"00299570-246d-11d0-a768-00aa006e0529"

# Add ACE for ResetPassword right
$ace = New-Object System.DirectoryServices.ActiveDirectoryAccessRule (
    $attackerSID,
    "ExtendedRight",
    "Allow",
    $resetPasswordGUID,
    "None"
)

$acl.AddAccessRule($ace)
$targetADSI.ObjectSecurity = $acl
$targetADSI.CommitChanges()

Write-Host "✅ 'leo' now has ForceChangePassword rights on user 'mia'" -ForegroundColor Green
