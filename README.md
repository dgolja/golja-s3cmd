#s3cmd puppet module

##Overview

Install s3cmd on Ubuntu/Debian/RedHat/CentOS/Amazon AMI from OS repo or in RedHat/CentOS case from the [s3tools repository](http://s3tools.org/s3cmd).

Tested with Travis

[![Build Status](https://travis-ci.org/n1tr0g/golja-s3cmd.png)](https://travis-ci.org/n1tr0g/golja-s3cmd)

##Installation

     $ puppet module install golja/s3cmd

##Usage

###Install s3cmd package

```puppet
include '::s3cmd'
```

###Create .s3cfg configuration for user root

```puppet
s3cmd::config {'root':
  aws_access_key => 'AUIAJYSJQT5WQ5S7EISQ',
  aws_secret_key  => 'Kd24SfkdcQfsS4294MSKAS432',
}
```

###Create multiple .s3cfg files with hiera

```yaml
--
s3cmd::config:
  root:
    aws_access_key: 'AUIAJYSJQT5WQ5S7EISQ'
    aws_secret_key: 'Kd24SfkdcQfsS4294MSKAS432'
  root_other:
    aws_access_key: 'AUIAJYSJQT5WQ5S7EISQ'
    aws_secret_key: 'Kd24SfkdcQfsS4294MSKAS432'
    user: 'root'
    filename: '.s3cmd-other'
```

And simply include s3cmd module:

```puppet
include '::s3cmd'
```


###Parameters

####s3cmd

#####`ensure`

Valid value present/absent

####s3cmd::config

#####`aws_access_key`

**REQUIRED** - AWS key with S3 privileges to modify data in the S3

#####`aws_secret_key`

**REQUIRED** - AWS secret key

#####`ensure`

Remove or install the s3cmd config file. Possible values present or absent
`Default: present`

#####`filename`

The filename of the deployed config. *Default: .s3cfg*

#####`bucket_location`

AWS S3 supports the following buckets:
US, EU or eu-west-1, us-west-1 (Oregon),  us-west-1 (N California),
ap-southeast-1 (Singapore), ap-southeast-2 (Sydney), ap-northeast-1 (Tokyo)
and sa-east-1 (Sao Paulo). *Default: US*

#####`host_base`

The base host to use. You'll want to change this if using a different
bucket_location. *Default: s3.amazonaws.com*

#####`host_bucket`

The hostname that resolves to your bucket. You'll want to change this if
using a different bucket_location. *Default: %(bucket)s.s3.amazonaws.com*

#####`use_https`

If use HTTPS protocol for communication with Amazon S3. *Default: True*

#####`encryption_passphrase`

Encryption password is used to protect your files from reading
by unauthorized persons while in transfer to S3. *Default: undef*

#####`encrypt`

Client side encryption. *Default: false*

#####`user`

system username which defines the .s3cfg file location. *Default: $title*

#####`home_dir`

Overwrites the default home dir of the user in case you are not
using /home or /root for root. *Default: undef*

#####`path_to_gpg`

Path to GPG if encryption is enabled. *Default: /usr/bin/gpg*

#####`proxy_host`

Proxy server. *Default: undef*

#####`proxy_port`

Proxy port. *Default: undef*

## Supported Platforms

* Debian Wheezy
* Ubuntu 12+
* RedHat 5/6
* CentOS 5/6
* Amazon AMI

## License

See LICENSE file
