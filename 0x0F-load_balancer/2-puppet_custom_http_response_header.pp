# Configure Puppet to add a custom HTTP header

# Define variables
$link = 'https://www.youtube.com/watch?v=PCfiqY05BpA'
$content = "\trewrite ^/redirect_me/$ ${link} permanent;"
$custom_header = "add_header X-Served-By \$hostname;"

# Update packages
exec { 'update packages':
  command => '/usr/bin/apt-get update'
}

# Restart Nginx service
exec { 'restart nginx':
  command => '/usr/sbin/service nginx restart',
  require => Package['nginx']
}

# Install Nginx package
package { 'nginx':
  ensure  => 'installed',
  require => Exec['update packages']
}

# Create default index.html file
file { '/var/www/html/index.html':
  ensure  => 'present',
  content => 'Hello World!',
  mode    => '0644',
  owner   => 'root',
  group   => 'root'
}

# Set up 301 redirection in Nginx configuration
file_line { 'Set 301 redirection':
  ensure   => 'present',
  after    => 'server_name\ _;',
  path     => '/etc/nginx/sites-available/default',
  multiple => true,
  line     => $content,
  notify   => Exec['restart nginx'],
  require  => File['/var/www/html/index.html']
}

# Add custom X-Served-By header in Nginx configuration
file_line { 'Set X-Served-By header':
  ensure   => 'present',
  after    => 'http {',
  path     => '/etc/nginx/nginx.conf',
  multiple => true,
  line     => $custom_header,
  notify   => Exec['restart nginx'],
  require  => File['/var/www/html/index.html']
}
