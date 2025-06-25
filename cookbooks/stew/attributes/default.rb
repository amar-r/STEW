# Baseline attributes for CIS hardening

# Password Policy (CIS 1.1.x)
default['stew']['password_policy']['minimum_password_length'] = 14
default['stew']['password_policy']['password_complexity'] = 1
default['stew']['password_policy']['maximum_password_age'] = 365
default['stew']['password_policy']['minimum_password_age'] = 1
default['stew']['password_policy']['password_history_size'] = 24

# Account Lockout Policy (CIS 1.2.x)
default['stew']['account_lockout']['lockout_duration'] = 15
default['stew']['account_lockout']['lockout_threshold'] = 5
default['stew']['account_lockout']['reset_lockout_counter'] = 15

# Audit Policy (CIS 17.x)
default['stew']['audit_policy']['AuditLogonEvents'] = 'Success and Failure'
default['stew']['audit_policy']['AuditAccountLogonEvents'] = 'Success and Failure'
default['stew']['audit_policy']['AuditObjectAccess'] = 'Success and Failure'
default['stew']['audit_policy']['AuditPrivilegeUse'] = 'Success and Failure'
default['stew']['audit_policy']['AuditPolicyChange'] = 'Success and Failure'
default['stew']['audit_policy']['AuditAccountManagement'] = 'Success and Failure'
default['stew']['audit_policy']['AuditDirectoryServiceAccess'] = 'Success and Failure'
default['stew']['audit_policy']['AuditSystemEvents'] = 'Success and Failure'

# Security Options (CIS 2.x)
default['stew']['security_options']['accounts_guest_status'] = 'Disabled'
default['stew']['security_options']['accounts_limit_local_account_use'] = 'Enabled'
default['stew']['security_options']['accounts_rename_admin_account'] = 'Administrator'
default['stew']['security_options']['accounts_rename_guest_account'] = 'Guest'

# Services to disable (CIS 3.x)
default['stew']['services']['disable'] = [
  'Telnet',
  'RemoteRegistry',
  'SNMP',
  'SNMPTRAP',
  'W32Time',
  'WSearch',
  'XboxNetApiSvc'
]

# User Rights Assignment (CIS 4.x)
default['stew']['user_rights']['access_credential_manager_as_trusted_caller'] = []
default['stew']['user_rights']['access_this_computer_from_network'] = ['Administrators', 'Authenticated Users']
default['stew']['user_rights']['act_as_part_of_operating_system'] = []
default['stew']['user_rights']['adjust_memory_quotas_for_process'] = ['Administrators', 'LOCAL SERVICE', 'NETWORK SERVICE']
