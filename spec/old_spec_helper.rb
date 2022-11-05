require 'simplecov'
SimpleCov.start

require_relative 'item_spec'
require_relative 'item_repositroy_spec'
require_relative 'merchant_spec'
require_relative 'merchant_repository_spec'
require_relative 'sales_analyst_spec'
require_relative "sales_engine_spec"

# See https://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
RSpec.configure do |config|
    # rspec-expectations config goes here. You can use an alternate
    # assertion/expectation library such as wrong or the stdlib/minitest
    # assertions if you prefer.
    config.expect_with :rspec do |expectations|
      # This option will default to `true` in RSpec 4. It makes the `description`
      # and `failure_message` of custom matchers include text for helper methods
      # defined using `chain`, e.g.:
      #     be_bigger_than(2).and_smaller_than(4).description
      #     # => "be bigger than 2 and smaller than 4"
      # ...rather than:
      #     # => "be bigger than 2"
      expectations.include_chain_clauses_in_custom_matcher_descriptions = true
    end
  
    # rspec-mocks config goes here. You can use an alternate test double
    # library (such as bogus or mocha) by changing the `mock_with` option here.
    config.mock_with :rspec do |mocks|
      # Prevents you from mocking or stubbing a method that does not exist on
      # a real object. This is generally recommended, and will default to
      # `true` in RSpec 4.
      mocks.verify_partial_doubles = true
    end
  
    # This option will default to `:apply_to_host_groups` in RSpec 4 (and will
    # have no way to turn it off -- the option exists only for backwards
    # compatibility in RSpec 3). It causes shared context metadata to be
    # inherited by the metadata hash of host groups and examples, rather than
    # triggering implicit auto-inclusion in groups with matching metadata.
    config.shared_context_metadata_behavior = :apply_to_host_groups
  
  # The settings below are suggested to provide a good initial experience
  # with RSpec, but feel free to customize to your heart's content.
   
  end