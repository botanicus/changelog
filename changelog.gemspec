#!/usr/bin/env gem build
# encoding: utf-8

$:.unshift(File.join(File.dirname(__FILE__), "lib"))
require "changelog"

Gem::Specification.new do |s|
  s.name = "changelog"
  s.version = "0.0.1"
  s.authors = ["Jakub Šťastný aka Botanicus"]
  s.homepage = "http://github.com/botanicus/changelog"
  s.summary = "Simple CHANGELOG parser"
  s.description = "" # TODO: long description
  s.cert_chain = nil
  s.email = ["knava.bestvinensis", "gmail.com"].join("@")
  s.has_rdoc = true

  # files
  s.files = Dir.glob("*/**")
  s.require_paths = ["lib"]

  changelog = CHANGELOG.new(File.join(File.dirname(__FILE__), "CHANGELOG"))
  s.post_install_message = "=== Changes in the last version of CHANGELOG ===\n  - #{changelog.last_version_changes.join("\n-  ")}"

  # RubyForge
  s.rubyforge_project = "changelog"
end
