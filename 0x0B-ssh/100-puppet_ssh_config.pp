# Ensure SSH client configuration file exists
file { '/etc/ssh/ssh_config':
  ensure  => 'present'
}

# Ensure PasswordAuthentication is set to no
file_line { 'Turn off passwd auth':
  path    => '/etc/ssh/ssh_config',
  line    => 'PasswordAuthentication no',
  match   => '^PasswordAuthentication',
}

# Ensure IdentityFile is set to ~/.ssh/school
file_line { 'Declare identity file':
  path    => '/etc/ssh/ssh_config',
  line    => 'IdentityFile ~/.ssh/school',
  match   => '^IdentityFile',
}
