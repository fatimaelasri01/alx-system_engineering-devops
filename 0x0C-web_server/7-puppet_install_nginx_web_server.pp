# Puppet manifest to install Nginx and configure redirection
# onfigures server with puppet
package { 'nginx':
  ensure => present,
}

exec { 'install_nginx':
  command  => '/usr/bin/apt-get update && /usr/bin/apt-get -y install nginx',
  provider => shell,
  require  => Package['nginx'],
}

file { '/var/www/html/index.html':
  ensure  => present,
  content => 'Hello World!',
}

file_line { 'nginx_redirect':
  path    => '/etc/nginx/sites-available/default',
  line    => '    location /redirect_me { return 301 https://www.youtube.com/@themathsclub/; }',
  match   => 'listen 80 default_server;',
  notify  => Exec['restart_nginx'],
  require => Package['nginx'],
}

exec { 'restart_nginx':
  command     => '/usr/sbin/service nginx restart',
  provider    => shell,
  refreshonly => true,
}

