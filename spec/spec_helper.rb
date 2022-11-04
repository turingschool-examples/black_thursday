require 'simplecov'
SimpleCov.start

require_relative 'merchant_spec'
require_relative 'merchant_repository_spec'
require_relative 'item_spec'
require_relative 'item_repository_spec'
require_relative 'invoice_spec'
require_relative 'invoice_repository_spec'
require_relative 'sales_engine_spec'
require_relative 'sales_analyst_spec'

spec_harness_root = File.expand_path('..',  __dir__)
unless File.expand_path(Dir.pwd) == spec_harness_root
  die_because.call "Run the program from the root of the Spec Harness (#{spec_harness_root.inspect})"
end

module BlackThursdaySpecHelpers
  class << self
    attr_accessor :engine
  end

  def engine
    BlackThursdaySpecHelpers.engine
  end
end

RSpec.configure do |config|
  config.disable_monkey_patching!

  config.before(:suite) do
    BlackThursdaySpecHelpers.engine = SalesEngine.from_csv({
      items: File.join(spec_harness_root, 'data', 'items.csv'),
      merchants: File.join(spec_harness_root, 'data', 'merchants.csv'),
      customers: File.join(spec_harness_root, 'data', 'customers.csv'),
      invoices: File.join(spec_harness_root, 'data', 'invoices.csv'),
      invoice_items: File.join(spec_harness_root, 'data', 'invoice_items.csv'),
      transactions: File.join(spec_harness_root, 'data', 'transactions.csv'),
    })
  end
  File.join spec_harness_root, 'data'
  config.include BlackThursdaySpecHelpers
end