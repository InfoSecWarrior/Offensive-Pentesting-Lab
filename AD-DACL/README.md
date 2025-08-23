
# Active Directory DACL Exploitation Lab

This directory contains PowerShell scripts to configure a **vulnerable Active Directory lab** used for testing various **DACL misconfigurations** and their real-world exploitability.


## Objective

The lab helps you understand and exploit:
- AddSelf
- WriteOwner
- WriteDACL
- GenericWrite
- GenericAll
- ForceChangePassword
- AllExtendedRights


## Setup Phase (Run These 3 Scripts First)

> These 3 scripts must be executed **in order** on a fresh Windows Server machine before running any lab scripts.

### 1. Rename the Computer

```powershell
.\Rename-And-Restart.ps1
````

* Renames the system to `Infosec`
* Automatically restarts the machine


### 2. Install Active Directory and Promote to Domain Controller

```powershell
.\Install-ADDS-And-Promote.ps1
```

* Installs the AD Domain Services role
* Promotes the machine to a Domain Controller for the domain `armour.local`
* Triggers automatic reboot


### 3. Create 20 Active Directory Users

```powershell
.\Create-AD-Users.ps1
```

* Creates 20 test users with default password `Password@123`
* Users will be used for misconfiguration & exploitation in later labs


## DACL Lab Phase (Run These After Setup)

After completing the setup phase and confirming that the Domain Controller is operational with all users, you can proceed to configure each DACL lab.

Each lab script introduces a specific misconfiguration in Active Directory ACLs. **Run each individually** as per your testing requirements.

### DACL Labs List

| Script Name                         | Purpose / Misconfiguration                 |
|-------------------------------------|---------------------------------------------|
| [DACL_Lab_1_AddSelf_DA.ps1](Labs/DACL_Lab_1_AddSelf_DA.ps1)         | AddSelf on Domain Admins                   |
| [DACL_Lab_2_AddSelf_Backup.ps1](Labs/DACL_Lab_2_AddSelf_Backup.ps1)     | AddSelf on Backup Operators                |
| [DACL_Lab_3_WriteOwner_DA.ps1](Labs/DACL_Lab_3_WriteOwner_DA.ps1)      | WriteOwner on Domain Admins                |
| [DACL_Lab_4_WriteOwner_User.ps1](Labs/DACL_Lab_4_WriteOwner_User.ps1)    | WriteOwner on another user object          |
| [DACL_Lab_5_WriteDacl_DA.ps1](Labs/DACL_Lab_5_WriteDacl_DA.ps1)       | WriteDACL on Domain Admins group           |
| [DACL_Lab_6_WriteDacl_User.ps1](Labs/DACL_Lab_6_WriteDacl_User.ps1)     | WriteDACL on user object                   |
| [DACL_Lab_7_GenericWrite_DA.ps1](Labs/DACL_Lab_7_GenericWrite_DA.ps1)    | GenericWrite on Domain Admins              |
| [DACL_Lab_8_GenericWrite_User.ps1](Labs/DACL_Lab_8_GenericWrite_User.ps1)  | GenericWrite on another user               |
| [DACL_Lab_9_ForceChangePwd.ps1](Labs/DACL_Lab_9_ForceChangePwd.ps1)     | ForceChangePassword on another user        |
| [DACL_Lab_10_AllExtended.ps1](Labs/DACL_Lab_10_AllExtended.ps1)       | AllExtendedRights on another user          |
| [DACL_Lab_11_GenericAll_DA.ps1](Labs/DACL_Lab_11_GenericAll_DA.ps1)     | GenericAll on Domain Admins                |
| [DACL_Lab_12_GenericAll_User.ps1](Labs/DACL_Lab_12_GenericAll_User.ps1)   | GenericAll on another user                 |


