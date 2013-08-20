class apache2 (
  $apache_port = '80',
  $root_domain = 'dev.opensourcery.com'
  ) {

  package { "apache2": }
  package { "apache2.2-common": }
  package { "libapache2-mod-php5": }
  package { "dnsmasq": }

  service { "apache2":
    ensure => "running",
    enable => "true",
    require => Package["apache2"],
  }

  service { "dnsmasq":
    ensure => "running",
    enable => "true",
    require => Package['dnsmasq'],
  }

  # Drupal 6
  # TODO

  # Drupal 7
  file { "/etc/apache2/sites-available/dev7":
    notify => Service["apache2"],
    ensure => "present",
    content => template("apache2/vhost.d7.erb"),
    require => Package["apache2"],
  }

  # Drupal 8
  # TODO

  # dnsmasq config
  file { '/etc/dnsmasq.d/dev':
    notify => Service['dnsmasq'],
    ensure => 'present',
    content => template('apache2/dnsmasq.erb'),
    require => Package['dnsmasq'],
  }
  
  exec { "apache modules":
    notify => Service["apache2"],
    command => "/usr/sbin/a2enmod vhost_alias rewrite expires headers",
    require => Package["apache2"],
  }

  # ensure directories are in place
  file { [ '/var/www/dev7' ]:
    ensure => 'directory',
  }
}
