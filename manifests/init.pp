# == Class: s3cmd
#
# Manage and configure s3cmd from http://s3tools.org/
#
# === Parameters
#
# [*$ensure*]
#   Remove or install the s3tools package. Possible values
#   present or absent
#
# === Examples
#
#  include s3cmd
#
# === Author
#
# Dejan Golja <dejan@golja.org>
#

class s3cmd(
  $ensure = 'present'
) inherits s3cmd::params {

  if !($ensure in ['present', 'absent']) {
    fail('ensure must be either present or absent')
  }

  if $::osfamily == 'RedHat' or $::operatingsystem == 'Amazon' {
    yumrepo { 's3tools':
      descr    => $s3cmd::params::description,
      baseurl  => $s3cmd::params::baseurl,
      gpgkey   => $s3cmd::params::gpgkey,
      gpgcheck => 1,
      enabled  => 1,
    } -> Package['s3cmd']
  }

  package {'s3cmd':
    ensure => $ensure,
    name   => $s3cmd::params::package_name,
  }

  # auto-create configs from hiera
  create_resources('s3cmd::config', hiera_hash('s3cmd::config', {}))
}
