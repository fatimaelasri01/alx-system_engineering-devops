#Change the OS configuration to log with the holberton user
exec { '/usr/bin/env sed -i "s/holberton/foo/" /etc/security/limits.conf': }
