# Define our WP CLI class
class wp_cli (
  $config
) {
  # Puppet 3.8 doesn't have the .each function and we need an alternative.
  define install_package {
    exec { "Installing the ${name} WP-CLI package":
      environment => [ 'COMPOSER_HOME=/usr/bin/composer', 'WP_CLI_PACKAGES_DIR=/home/vagrant/.wp-cli/packages/' ],
      path        => [ '/bin/', '/sbin/', '/usr/bin/', '/usr/sbin/' ],
      command     => "wp package install $name --allow-root",
      require     => [ Exec['install composer'] ]
    }
  }

  define uninstall_package {
    exec { "Uninstalling the ${name} WP-CLI package":
      environment => [ 'COMPOSER_HOME=/usr/bin/composer', 'WP_CLI_PACKAGES_DIR=/home/vagrant/.wp-cli/packages/' ],
      path        => [ '/bin/', '/sbin/', '/usr/bin/', '/usr/sbin/' ],
      command     => "wp package uninstall $name --allow-root",
      require     => [ Exec['install composer'] ]
    }
  }

  if ( ! empty( $config[disabled_extensions] ) and 'wp_cli' in $config[disabled_extensions] ) {
    $package = absent
  } else {
    $package = latest
  }

  if ( $package == 'latest' ) {
    $content_path = $config[mapped_paths][content]
    # Increase the memory limit for WP-CLI: https://bit.ly/wpclimem
    file { "$content_path/custom.ini":
      ensure => present
    }
    file_line { 'memory_limit':
      path  => "$content_path/custom.ini",
      line  => 'memory_limit = 1024M',
      match => '^memory_limit\ =',
    }
    if ( $config[wp_cli] and $config[wp_cli][packages]) {
      install_package { $config[wp_cli][packages]: }
    }
  }
}
