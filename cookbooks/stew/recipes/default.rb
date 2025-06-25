#
# Cookbook:: stew
# Recipe:: default
#

# Password Policy (CIS 1.1.1, 1.1.2, 1.1.3, 1.1.4, 1.1.5)
registry_key 'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa' do
  values [
    { name: 'MinimumPasswordLength', type: :dword, data: node['stew']['password_policy']['minimum_password_length'] },
    { name: 'PasswordComplexity', type: :dword, data: node['stew']['password_policy']['password_complexity'] }
  ]
  action :create
end

registry_key 'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon' do
  values [
    { name: 'PasswordExpiryWarning', type: :dword, data: 14 }
  ]
  action :create
end

# Account Lockout Policy (CIS 1.2.1, 1.2.2, 1.2.3)
registry_key 'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' do
  values [
    { name: 'LockoutDuration', type: :dword, data: node['stew']['account_lockout']['lockout_duration'] },
    { name: 'LockoutThreshold', type: :dword, data: node['stew']['account_lockout']['lockout_threshold'] },
    { name: 'ResetLockoutCount', type: :dword, data: node['stew']['account_lockout']['reset_lockout_counter'] }
  ]
  action :create
end

# Security Options (CIS 2.1.1, 2.1.2, 2.1.3, 2.1.4)
registry_key 'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa' do
  values [
    { name: 'LimitBlankPasswordUse', type: :dword, data: 1 }
  ]
  action :create
end

registry_key 'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa' do
  values [
    { name: 'NoLMHash', type: :dword, data: 1 }
  ]
  action :create
end

# Audit Policy (CIS 17.2.1, 17.2.2, 17.2.3, 17.2.4, 17.2.5, 17.2.6, 17.2.7, 17.2.8)
audit_policies = {
  'Logon/Logoff' => 'Logon',
  'Logon/Logoff' => 'Logoff',
  'Logon/Logoff' => 'Account Lockout',
  'Object Access' => 'File System',
  'Object Access' => 'Registry',
  'Privilege Use' => 'Sensitive Privilege Use',
  'Policy Change' => 'Audit Policy Change',
  'Policy Change' => 'Authentication Policy Change',
  'Account Management' => 'User Account Management',
  'Account Management' => 'Computer Account Management',
  'Account Management' => 'Security Group Management',
  'Directory Service Access' => 'Directory Service Access',
  'System' => 'System Integrity'
}

audit_policies.each do |category, subcategory|
  windows_audit_policy "#{category}-#{subcategory}" do
    policy_name category
    subcategory subcategory
    success true
    failure true
    action :set
  end
end

# User Rights Assignment (CIS 4.1.1, 4.1.2, 4.1.3, 4.1.4)
registry_key 'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa' do
  values [
    { name: 'SeTrustedCredManAccessPrivilege', type: :multi_string, data: node['stew']['user_rights']['access_credential_manager_as_trusted_caller'] },
    { name: 'SeNetworkLogonRight', type: :multi_string, data: node['stew']['user_rights']['access_this_computer_from_network'] },
    { name: 'SeTcbPrivilege', type: :multi_string, data: node['stew']['user_rights']['act_as_part_of_operating_system'] },
    { name: 'SeIncreaseQuotaPrivilege', type: :multi_string, data: node['stew']['user_rights']['adjust_memory_quotas_for_process'] }
  ]
  action :create
end

# Disable insecure services (CIS 3.1.x, 3.2.x, 3.3.x, 3.4.x, 3.5.x, 3.6.x, 3.7.x)
node['stew']['services']['disable'].each do |svc|
  windows_service svc do
    action [:disable, :stop]
    only_if { ::Win32::Service.exists?(svc) }
  end
end

# Additional Security Settings
registry_key 'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management' do
  values [
    { name: 'ClearPageFileAtShutdown', type: :dword, data: 1 }
  ]
  action :create
end

registry_key 'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' do
  values [
    { name: 'ShutdownWithoutLogon', type: :dword, data: 0 },
    { name: 'UndockWithoutLogon', type: :dword, data: 0 }
  ]
  action :create
end
