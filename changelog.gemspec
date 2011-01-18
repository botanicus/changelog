#!/usr/bin/env gem build
# encoding: utf-8

$:.unshift(File.join(File.dirname(__FILE__), "lib"))

require "changelog"
require "base64"

Gem::Specification.new do |s|
  s.name = "changelog"
  s.version = "0.4"
  s.authors = ["Jakub Šťastný aka Botanicus"]
  s.homepage = "http://github.com/botanicus/changelog"
  s.summary = "Simple CHANGELOG parser for Ruby 1.9"
  s.description = "" # TODO: long description
  s.cert_chain = nil
  s.email = Base64.decode64("c3Rhc3RueUAxMDFpZGVhcy5jeg==\n")
  s.has_rdoc = true

  # files
  s.files = `git ls-files`.split("\n")

  s.require_paths = ["lib"]

  # ruby version
  s.required_ruby_version = ::Gem::Requirement.new("~> 1.9")

  # post install message
  s.post_install_message = CHANGELOG.new.version_changes

  # RubyForge
  s.rubyforge_project = "changelog"
end
