lib = File.expand_path("../lib/", __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'polarssl/version'

Gem::Specification.new do |s|
  s.name = 'mbedtls'
  s.version = PolarSSL::VERSION
  s.date = Date.today
  s.summary = 'Use the mbed TLS cryptographic and SSL library in Ruby.'
  s.description = 'A gem that lets you use the mbed TLS cryptography library with Ruby.'
  s.authors = ['Adam Caudill']
  s.email = 'adam@adamcaudill.com'
  s.files = `git ls-files`.split("\n")
  s.homepage = 'https://github.com/adamcaudill/mbedtls-ruby'
  s.license = 'LGPL-3'
  s.test_files = Dir.glob('test/*_test.rb')
  s.requirements = 'mbedtls, >= v2.4.x'
  #s.cert_chain = ["certs/michiels.pem"]
  #s.signing_key = File.expand_path("~/.ssh/gem-private_key.pem") if $0 =~ /gem\z/

  s.extensions = %w[ext/polarssl/extconf.rb]
end
