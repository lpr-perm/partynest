# frozen_string_literal: true

require_relative 'config/application'

Rails.application.load_tasks

desc 'Run all checks'
task all: %i[default extra]

desc 'Run common checks (test, lint...)'
task default: :rubocop

desc 'Run additional checks'
# task extra: %i[bundler:audit brakeman]
task extra: %i[brakeman]

desc 'Fix code style (rubocop --auto-correct)'
task fix: 'rubocop:auto_correct'

begin
  require 'coveralls/rake/task'
  Coveralls::RakeTask.new
rescue LoadError
  nil
end

begin
  require 'rubocop/rake_task'
  RuboCop::RakeTask.new
rescue LoadError
  nil
end

begin
  require 'yard'
  YARD::Rake::YardocTask.new
rescue LoadError
  nil
end

namespace :bundler do
  require 'bundler/audit/cli'

  desc 'Updates the ruby-advisory-db and ' \
       'checks the Gemfile.lock for insecure dependencies'
  task audit: %i[audit:update audit:check]

  namespace :audit do
    desc 'Updates the ruby-advisory-db'
    task :update do
      Bundler::Audit::CLI.start ['update']
    end

    desc 'Checks the Gemfile.lock for insecure dependencies'
    task :check do
      Bundler::Audit::CLI.start ['check']
    end
  end
rescue LoadError
  nil
end

desc 'Detects security vulnerabilities via static analysis'
task :brakeman do
  sh(
    'bundle',
    'exec',
    'brakeman',
    Rails.root.to_s,
    '--confidence-level',
    '1',
    '--run-all-checks',
  )
end
