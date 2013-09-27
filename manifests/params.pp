# == Class: s3cmd::params
#
# Manage and configure s3cmd from http://s3tools.org/
#

class s3cmd::params {

  case $::osfamily {
    'RedHat': {
      # s3cmd is not available by default so we had to add the repository
      $description = "Tools for managing Amazon S3 - Simple Storage Service (RHEL_${::operatingsystemmajrelease})"
      $baseurl = "http://s3tools.org/repo/RHEL_${::operatingsystemmajrelease}/"
      $gpgkey = "http://s3tools.org/repo/RHEL_${::operatingsystemmajrelease}/repodata/repomd.xml.key"
    }
    'Debian': {
      $package_name ='s3cmd'
    }
    'Linux': {
      if $::operatingsystem == 'Amazon' {
        $description = 'Tools for managing Amazon S3 - Simple Storage Service (Amazon)'
        $baseurl = 'http://s3tools.org/repo/RHEL_6/'
        $gpgkey = 'http://s3tools.org/repo/RHEL_6/repodata/repomd.xml.key'
      }
      else {
        fail("Osfamily ${::osfamily} with operating system ${::operatingsystem} is not supported")
      }
    }
    default: {
      fail("Osfamily ${::osfamily} is not supported")
    }
  }
}