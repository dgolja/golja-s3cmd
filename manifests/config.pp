# == Class: s3cmd::config
#
# Manage and configure s3cmd from http://s3tools.org/
#
# === Parameters
#
# [*$ensure*]
#   Remove or install the s3cmd config file. Possible values
#   present or absent
#
# [*$aws_access_key*]
#   AWS key with S3 privileges to modify data in the S3
#
# [*aws_secret_key*]
#   AWS secret key
#
# [*filename*]
#   The filename of the deployed config. Default: .s3cfg
#
# [*bucket_location*]
#   default bucket location is US. As for now AWS/s3md supports the
#   following buckets: US, EU or eu-west-1, us-west-1 (Oregon),
#   us-west-1 (Northern California), ap-southeast-1 (Singapore),
#    ap-southeast-2 (Sydney), ap-northeast-1 (Tokyo) and sa-east-1 (Sao Paulo)
#
# [*host_base*]
#   The base host to use. You'll want to change this if using a different
#   bucket_location. Default: s3.amazonaws.com
#
# [*host_bucket*]
#   The hostname that resolves to your bucket. You'll want to change this if
#   using a different bucket_location. Default: %(bucket)s.s3.amazonaws.com
#
# [*use_https*]
#   If use HTTPS protocol for communication with Amazon S3
#
# [*encryption_passphrase*]
#   Encryption password is used to protect your files from reading
#   by unauthorized persons while in transfer to S3
#
# [*encrypt*]
#   Client side encryption. Default: false
#
# [*user*]
#   system username which defines the .s3cfg file location.
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
  $aws_access_key,
  $aws_secret_key,
  $ensure                = 'present',
  $filename              = '.s3cfg',
  $user                  = $title,
  $bucket_location       = 'US',
  $host_base             = 's3.amazonaws.com',
  $host_bucket           = '%(bucket)s.s3.amazonaws.com',
  $use_https             = true,
  $encrypt               = false,
  $encryption_passphrase = undef,
  $path_to_gpg           = '/usr/bin/gpg',
  $proxy_host            = undef,
  $proxy_port            = 0,
  $home_dir              = undef
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

  file { "${home_path}/${filename}":
    ensure  => $ensure,
    content => template('s3cmd/s3cfg.erb'),
    owner   => $user,
    mode    => '0600',
  }
}
