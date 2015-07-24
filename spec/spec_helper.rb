require 'pry'
require_relative '../app/app'

DB = Sequel.sqlite

Mail.defaults do
  delivery_method :test
end

RSpec.configure do |config|
  config.include(Mail::Matchers)

  config.before(:each) do
    DB.create_table(:users) do
      primary_key :id

      column :name,     String
      column :email,    String
      column :birthday, DateTime
    end
  end

  config.after(:each) do
    Mail::TestMailer.deliveries.clear
    DB.drop_table(:users)
  end

  config.filter_run :focus
  config.run_all_when_everything_filtered = true

  if config.files_to_run.one?
    config.full_backtrace = true

    config.default_formatter = 'doc'
  end

  config.order = :random

  Kernel.srand(config.seed)

  config.disable_monkey_patching!
  config.warnings = false

  config.expect_with :rspec do |expectations|
    expectations.syntax = :expect
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.syntax = :expect
    mocks.verify_partial_doubles = true
    mocks.verify_doubled_constant_names = true
  end
end
