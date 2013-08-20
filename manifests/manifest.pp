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

# test host file structure
define testhosts {
  file {
    "/var/www/dev7/${title}":
      ensure => directory,
      owner => 'www-data',
      group => 'www-data',
      mode => 0775;
    "/var/www/dev7/${title}/shared":
      ensure => directory,
      owner => 'www-data',
      group => 'www-data',
      mode => 0775;
    "/var/www/dev7/${title}/shared/files":
      ensure => directory,
      owner => 'www-data',
      group => 'www-data',
      mode => 0775;
    "/var/www/dev7/${title}/releases":
      ensure => directory,
      owner => 'www-data',
      group => 'www-data',
      mode => 0775;
  }
}
testhosts { [
        'adams',
        'atka',
        'bachelor',
        'belknap',
        'capulin',
        'copahue',
        'demo',
        'dempo',
        'dotsero',
        'dynamic',
        'ekarma',
        'eldfell',
        'fentale',
        'fuego',
        'galeras',
        'gamalama',
        'hood',
        'hualalai',
        'isspah',
        'izalco',
        'jalua',
        'jornada',
        'kanaga',
        'karthala',
        'langila',
        'lopevi',
        'mojanda',
        'myoko',
        'nazko',
        'newberry',
        'okataina',
        'opala',
        'peinado',
        'pinatubo',
        'qualibou',
        'quilotoa',
        'rainier',
        'reventador',
        'shasta',
        'sotara',
        'sunbear',
        'trocon',
        'tsurumi',
        'undara',
        'uzon',
        'viedma',
        'visoke',
        'waiowa',
        'wurlali',
        'yantarni',
        'yellowstone',
        'zimina',
        'zukur'
        ]:
}
