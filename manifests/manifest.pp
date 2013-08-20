package { 'php5': }
package { 'php5-cli': }
package { 'php-apc': }
package { 'php5-mysql': }
package { 'php5-gd': }
package { 'php5-curl': }
package { "php-pear": }
package { "mysql-server": }
# Required for drush make
package { "zip": }
package { "git": }

service { 'mysql':
  ensure => 'running',
  enable => 'true',
  require => Package['mysql-server'],
}

exec { "install-drush":
    unless => "/usr/bin/which drush",
    command => "/usr/bin/pear channel-discover pear.drush.org; /usr/bin/pear upgrade-all; /usr/bin/pear install drush/drush; /usr/bin/drush -h",
    require => Package["php-pear"],
}

# vhosts
class { 'apache2':
  root_domain => 'dev.opensourcery.com',
  apache_port => 7000
}
