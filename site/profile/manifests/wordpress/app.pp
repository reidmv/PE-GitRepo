class profile::wordpress::app (
  $db_host,
) {
  include apache
  include apache::mod::php
  
  apache::vhost { 'wordpress':
    vhost_name => '*',
    port => '80',
    docroot => '/opt/wordpress',
    priority => '10',
  }
  
  
  package { 'wget':
    ensure => present,
    before => Wordpress::Instance::App['/opt/wordpress'],
  }
  
  package { 'php-mysql':
    ensure => present,
    notify => Class['apache'],
  }
  
  wordpress::instance::app { '/opt/wordpress':
    install_dir          => '/opt/wordpress',
    install_url          => 'http://wordpress.org',
    version              => '4.6.1',
    db_name              => 'wordpress',
    db_host              => $db_host,
    db_user              => lookup('wordpress_username'),
    db_password          => lookup('wordpress_passwd'),
    wp_owner             => 'root',
    wp_group             => '0',
    wp_lang              => '',
    wp_config_content    => undef,
    wp_plugin_dir        => 'DEFAULT',
    wp_additional_config => 'DEFAULT',
    wp_table_prefix      => 'wp_',
    wp_proxy_host        => '',
    wp_proxy_port        => '',
    wp_multisite         => false,
    wp_site_domain       => '',
    wp_debug             => false,
    wp_debug_log         => false,
    wp_debug_display     => false,
  }
}
