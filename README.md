#eyaml_functions [![Build Status](https://travis-ci.org/WhatsARanjit/puppet-eyaml-functions.svg?branch=master)](https://travis-ci.org/WhatsARanjit/puppet-eyaml-functions)

####Table of Contents
1. [Overview](#overview)
1. [Requirements](#requirements)
1. [Setup](#setup)
1. [Usage](#usage)

##Overview

This module provides a set of functions to describe file content from eyaml encrypted sources.

##Requirements

The functions in this module require that the [hiera-eyaml gem](https://github.com/TomPoulton/hiera-eyaml)
is installed and keys generated.  The backend does not need to be in use. The location of the public
and private keys are read from either a separate config or the hiera.yaml file.

##Setup

#### Non-Hiera Setup

Place a file at `$environmentpath/$environment/eyaml.yaml` with the location of they keys such as:

~~~
---
:eyaml:
  :pkcs7_private_key: /etc/puppetlabs/puppet/keys/private_key.pkcs7.pem
  :pkcs7_public_key: /etc/puppetlabs/puppet/keys/public_key.pkcs7.pem
~~~

Follow the same guidelines for key permissions listed for the [hiera-eyaml gem](https://github.com/TomPoulton/hiera-eyaml).

#### Hiera Setup

Follow the setup procedure for the [hiera-eyaml gem](https://github.com/TomPoulton/hiera-eyamli#hiera) Hiera configuration.
Public and private key locations will be read from `hiera.yaml` as long as no file at `$environmentpath/$environment/eyaml.yaml`
exists.

##Usage

#### `eyaml_string`

Converts an eyaml encrypted string to plain-text.

*Examples:*
~~~
eyaml_string('ENC[PKCS7,MIIBeQYJKoZIhvcNAQcDoIIBajCCAWYCAQAxggEhMIIBHQIBADAFMAACAQEwDQYJKoZIhvcNAQEBBQAEggEA0G2Cl2yCPlMsXkj3KOzMYO+kyXdSIoVad533Gr1FQaU7VqpM+rbt7CYM5WytFNYotsYyqxoSW3pGKKGxHL9f0c4q+xGZHV1GaHoR4rCnTps6fpyWVENkQJPZoEKi/fHSN2y+TryCf7Bt+3WRumkspZtUiZ0sG5G0kC80ssrDbbm2mSxwcZ1AvfEozcrCtCHJr3qxmFMEkHvhpW/roumuyhlgwhre6tkE7gqyntFrAR5Hzlt0Mk83Fg345qyKh/aq3iAv412/GgbKhFlHtMDcfW2y5ntZozuyvG7W73HQ64snRNR9JLUzZuhm0o/YQfUYFoSQIQIdi/TxCXb6nIZ46DA8BgkqhkiG9w0BBwEwHQYJYIZIAWUDBAEqBBD5w0KZx5jxul3GUbSUXpvDgBCO/6XLdwlHb16bagi0igXf]')
# return: "hello"
~~~

*Type*: rvalue.

#### `eyaml_file`

Converts an eyaml encrypted file to plain-text.

*Examples:*
~~~
# Assume /tmp/test.txt contains only the string in the above example
eyaml_file('/tmp/test.txt')
# return: "hello"

# Assume $modulepath/foo/files/test.txt contains only the string in the above example
eyaml_file('foo/test.txt')
# return: "hello"
~~~

*Type*: rvalue.
