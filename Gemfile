# encoding: utf-8
source ENV['GEM_SOURCE'] || 'https://rubygems.org'

# export INSPEC_VERSION="path: '/path/to/inspec'"
inspecversion = ENV.key?('INSPEC_VERSION') ? ENV['INSPEC_VERSION'] : ['>= 1.4.0']
trainversion = ENV.key?('TRAIN_VERSION') ? ENV['TRAIN_VERSION'] : ['>= 0.21.1']

gem 'inspec', inspecversion
gem 'pry', require: false
gem 'pry-doc', require: false
gem 'rake'
gem 'rb-readline', require: false
gem 'rspec-collection_matchers'
gem 'rubocop'
gem 'train', trainversion

group :tools do
  gem 'github_changelog_generator'
end
