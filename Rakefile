# frozen_string_literal: true

require 'rake/testtask'

desc 'Run all tests'
Rake::TestTask.new(:test) do |t|
  t.libs << 'spec'
  t.pattern = 'spec/**/*_spec.rb'
  t.verbose = true
  t.warning = false
end

desc 'Run plugin tests only'
Rake::TestTask.new(:test_plugins) do |t|
  t.libs << 'spec'
  t.pattern = 'spec/plugins/**/*_spec.rb'
  t.verbose = true
  t.warning = false
end

task default: :test
