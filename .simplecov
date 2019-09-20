# frozen_string_literal: true

# Setup simplecov

require 'simplecov'

SimpleCov.start 'rails' do
  add_filter '/test/'
  add_filter '/config/'
  add_filter '/db/'
  add_filter '/spec/'
  add_filter '/features/'

  add_group 'Controllers', 'app/controllers'
  add_group 'Models', 'app/models'
  add_group 'Helpers', 'app/helpers'
  add_group 'Libraries', 'app/lib'

  use_merging true
  merge_timeout 20 * 60
end

SimpleCov.at_exit do
  SimpleCov.result.format!
end
