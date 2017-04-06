PolarSSL for Ruby
=================

# IMPORTANT

This repository is a fork of [michiels/polarssl-ruby](https://github.com/michiels/polarssl-ruby) - it is being updated to reflect the new name of mbed TLS, and the changes that have occured over the last couple years since polarssl-ruby was last updated. For the moment, this repository should be seen as expirimental and unstable.

---------------------------

* API documentation: http://michiels.github.io/polarssl-ruby/doc
* RubyGems.org: http://rubygems.org/gems/polarssl

<table>
  <tr>
    <th>PolarSSL/mbed TLS version</th>
    <th>Gem version</th>
  </tr>
  <tr>
    <td>&lt;= 1.2.x</td><td>0.0.7</td>
  </tr>
  <tr>
    <td>&gt;= 1.3.0 and &lt; 1.3.10</td><td>1.0.1</td>
  </tr>
  <tr>
    <td>&gt;= 1.3.10</td><td>1.0.2</td>
  </tr>
</table>

## Description

With PolarSSL for Ruby, you can use SSL and cryptography functionality from PolarSSL in your Ruby programs.

## Features

* Encrypt/decrypt data.
* Set up encrypted SSL connections.

## Installation

PolarSSL is cryptographically signed. To be sure the gem you install hasn't been tampered with:

Add my public key as a trusted certificate:


```
gem cert --add <(curl -Ls https://raw.github.com/michiels/polarssl-ruby/master/certs/michiels.pem)
```

Then install the gem:

```
gem install polarssl -P HighSecurity
```

The `-P HighSecurity` will verify signed gems.

Or in your Gemfile:

```
gem "polarssl", "~> 1.0.2"
```

And install using:

```
bundle install --trust-policy HighSecurity
```

## Usage

### Setting up a SSL connection

This gem provides a pretty low level interface to the native PolarSSL C library.
The core API aims to reflect the PolarSSL library as much as possible. See the
[full API documentation](http://michiels.github.io/polarssl-ruby/doc/) for all classes and methods.

```ruby
require 'polarssl'

socket = TCPSocket.new('polarssl', 443)

entropy = PolarSSL::Entropy.new
ctr_drbg = PolarSSL::CtrDrbg.new(entropy)

ssl = PolarSSL::SSL.new
ssl.set_endpoint(PolarSSL::SSL::SSL_IS_CLIENT)
ssl.set_authmode(PolarSSL::SSL::SSL_VERIFY_NONE)
ssl.set_rng(ctr_drbg)
ssl.set_socket(socket)

ssl.handshake

ssl.write("GET / HTTP/1.0\r\nHost: polarssl.org\r\n\r\n")

while chunk = ssl.read(1024)
  response << chunk
end

puts response

ssl.close_notify

socket.close

ssl.close
```

### Encrypting data

The `PolarSSL::Cipher` class lets you encrypt data with a wide range of
encryption standards like AES, Blowfish and DES.

This sample encrypts a given plaintext with AES128 in CTR mode:

```ruby
require 'polarssl'
require 'base64'

cipher = PolarSSL::Cipher.new("AES-128-CTR")

my_iv = SecureRandom.random_bytes(16)

cipher.set_iv(my_iv, 16)
cipher.setkey("my16bytekey23456", 128, PolarSSL::Cipher::OPERATION_ENCRYPT)
cipher.update("some secret message I want to keep")
encrypted_data = cipher.finish

encoded_encrypted_data = Base64.encode64(encrypted_data)
encoded_iv = Base64.encode64(my_iv)
```

See the documentation for the `Cipher` class in the [API documentation](http://michiels.github.io/polarssl-ruby/doc)
for all the available options.

## Contributing

Install PolarSSL from source via https://polarssl.org/download or install it using your operating system. For example:

On Ubuntu:

```
sudo apt-get install libpolarssl-dev
```

On Mac OS X with [Homebrew](http://mxcl.github.io/homebrew/):

```
brew install polarssl
```

The following steps and commands are followed during development:

1. A branch is created.
2. Tests are created in `test/` before code is written and ran with `rake test`. This rake task takes care of compiling the binary and executing the tests.
3. Code is written.
4. A pull request is created.
5. CI runs and verifies passing tests of the Pull Request.
6. The pull request is merged in.
7. Repeat.

Tools used when developing:

* Travis CI (http://travis-ci.org)
* MiniTest (built into Ruby 1.9 or newer)
* GitHub

## License

*Please note*: PolarSSL itself is released as GPL or a Commercial License.
You will need to take this into account when using PolarSSL and this Ruby extension in your
own software.

```
polar-ssl-ruby - A Ruby extension for using PolarSSL.
Copyright (C) 2013  Michiel Sikkes

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
```
