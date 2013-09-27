# == Class: s3cmd::config
#
# Manage and configure s3cmd from http://s3tools.org/
#
# === Parameters
#
# [*$aws_access_key*]
#   AWS key with S3 privileges to modify data in the S3
#
# [*aws_secret_key*]
#   AWS secret key
#
# [*bucket_location*]
#   default bucket location is US. As for now AWS/s3md supports the
#   following buckets: US, EU or eu-west-1, us-west-1 (Oregon), 
#   us-west-1 (Northern California), ap-southeast-1 (Singapore), 
#    ap-southeast-2 (Sydney), ap-northeast-1 (Tokyo) and sa-east-1 (Sao Paulo)
#
# [*use_https*]
#   If use HTTPS protocol for communication with Amazon S3
#
# [*encryption_passphrase*]
#   Encryption password is used to protect your files from reading
#   by unauthorized persons while in transfer to S3
#
# [*user*]
#   system username for where to install the s3cmd config file
#
# [*path_to_gpg*]
#   Path to GPG program needed for encryption 
#
# [*home_dir*]
#   overwrites the default home dir of the user in case you are not 
#   using /home or /root for root
#
# === Examples
#
#  s3cmd::config { 'dejan':
#    aws_access_key  => 'AUIAJYSJQT5WQ5S7EISQ',
#    aws_secret_key  => 'Kd24SfkdcQfsS4294MSKAS432',
#    bucket_location => 'EU',
#  }
#
# === Author
#
# Dejan Golja <dejan@golja.org>
#

define s3cmd::config(
  $ensure = 'present',
  $user = $title, 
  $aws_access_key,
  $aws_secret_key,
  $bucket_location         = 'US',
  $use_https               = true,
  $encryption_passphrase   = undef,
  $path_to_gpg             = '/usr/bin/gpg',
  $home_dir                 = undef,
) {

  if !($ensure in ['present', 'absent']) {
    fail('ensure must be either present or absent')
  }
    
  if $home_dir {
    $home_path = $home_dir
  }
  else {
    $home_path = $user ? {
      'root'  => '/root',
      default => "/home/${user}"   
    }
  }
  
  file { "${home_path}/.s3cfg":
    ensure  => $ensure,
    content => template('s3cmd/s3cfg.erb'),
    owner   => $user,
    mode    => '0600',
  }
  
}