# ===============================================
# Lab 4: Grant 'david' WriteOwner on user 'emma'
# ===============================================

Import-Module ActiveDirectory

# Attacker: david
$attacker = Get-ADUser "david"
$attackerSID = New-Object System.Security.Principal.SecurityIdentifier($attacker.SID)

# Victim: emma
$victim = Get-ADUser "emma"
$victimDN = $victim.DistinguishedName
$victimDE = [ADSI]"LDAP://$victimDN"
$acl = $victimDE.ObjectSecurity

# Grant WriteOwner
$ace = New-Object System.DirectoryServices.ActiveDirectoryAccessRule(
    $attackerSID,
    "WriteOwner",
    "Allow"
)

$acl.AddAccessRule($ace)
$victimDE.ObjectSecurity = $acl
$victimDE.CommitChanges()

Write-Host "✅ 'david' now has WriteOwner on user 'emma'" -ForegroundColor Green
