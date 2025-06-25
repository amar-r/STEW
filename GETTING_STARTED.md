# Getting Started with STEW - CIS Windows Server 2022 Hardening

## Prerequisites
- Windows Server 2022 VM (you have this in UTM)
- Administrator access to the Windows VM

## Step 1: Install Chef Client on Windows VM

1. **Open PowerShell as Administrator** on your Windows Server 2022 VM
2. **Download Chef Client** (open source):
   ```powershell
   Invoke-WebRequest -Uri "https://downloads.chef.io/chef-client/latest/windows/2019/chef-client-*-x64.msi" -OutFile "chef-client.msi"
   ```
3. **Install Chef Client**:
   ```powershell
   Start-Process msiexec.exe -Wait -ArgumentList '/I chef-client.msi /quiet'
   ```
4. **Restart PowerShell** and verify installation:
   ```powershell
   chef-client --version
   ```

## Step 2: Copy STEW Project to Windows VM

### Option A: Using UTM Shared Folders
1. In UTM, enable shared folders between your Mac and Windows VM
2. Copy the `cookbooks/stew` folder to the Windows VM (e.g., `C:\STEW\cookbooks\stew`)

### Option B: Manual Copy
1. Copy the `cookbooks/stew` folder from your Mac to the Windows VM
2. Place it in a directory like `C:\STEW\cookbooks\stew`

## Step 3: Run Chef to Apply CIS Settings

1. **Open PowerShell as Administrator** on Windows VM
2. **Navigate to your STEW directory**:
   ```powershell
   cd C:\STEW
   ```
3. **Run Chef in local mode**:
   ```powershell
   chef-client --local-mode --runlist 'recipe[stew::default]'
   ```

## Step 4: Verify the Changes

After Chef runs successfully, you can verify the CIS settings were applied:

### Check Password Policy
```powershell
net accounts
```

### Check Account Lockout Policy
```powershell
net accounts /domain
```

### Check Audit Policy
```powershell
auditpol /get /category:*
```

### Check Services Status
```powershell
Get-Service | Where-Object {$_.Name -in @('Telnet', 'RemoteRegistry', 'SNMP')}
```

## What This Cookbook Does

The STEW cookbook applies these CIS benchmark settings:

### Password Policy (CIS 1.1.x)
- Minimum password length: 14 characters
- Password complexity: Enabled
- Maximum password age: 365 days
- Password history: 24 passwords

### Account Lockout Policy (CIS 1.2.x)
- Lockout duration: 15 minutes
- Lockout threshold: 5 failed attempts
- Reset lockout counter: 15 minutes

### Audit Policy (CIS 17.x)
- Logon/Logoff events: Success and Failure
- Object access: Success and Failure
- Privilege use: Success and Failure
- Policy changes: Success and Failure
- Account management: Success and Failure

### Security Options (CIS 2.x)
- Limit blank password use
- Disable LM hash storage
- Clear page file at shutdown
- Require logon for shutdown

### Services (CIS 3.x)
- Disables insecure services: Telnet, RemoteRegistry, SNMP, etc.

### User Rights Assignment (CIS 4.x)
- Configures various user rights according to CIS recommendations

## Troubleshooting

### If Chef fails to run:
1. Ensure you're running PowerShell as Administrator
2. Check that Chef Client is properly installed
3. Verify the cookbook path is correct

### If some settings don't apply:
1. Some settings may require a reboot to take effect
2. Check Windows Event Logs for errors
3. Verify the registry paths are correct for your Windows version

## Next Steps

1. **Test the hardened system** to ensure it meets your requirements
2. **Add more CIS controls** by expanding the cookbook
3. **Create a backup** of your VM before applying changes
4. **Document any customizations** you make to the cookbook

## Important Notes

- **Backup your VM** before running Chef for the first time
- **Test in a non-production environment** first
- **Some settings may require a reboot** to take full effect
- **Review the CIS benchmark documentation** for complete details on each setting 