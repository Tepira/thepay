# encoding: utf-8

$:.push File.expand_path("../lib", __FILE__)
require "thepay/version"
require "date"

Gem::Specification.new do |s|
  s.name          = "thepay"
  s.version       = ThePay::VERSION
  s.date          = Date.today
  s.summary       = "Simple integration with ThePay gateway"
  s.description   = "Simple integration with ThePay gateway"
  s.author        = "Martin Kost"
  s.email         = "info@tepira.com"
  s.files         = `git ls-files`.split("\n")
  s.homepage      = "http://github.com/bonekost/thepay"

  s.require_paths = ["lib"]
end
