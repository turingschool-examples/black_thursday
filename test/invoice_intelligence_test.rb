require_relative 'test_helper'
require_relative './test_setup'

require './lib/sales_engine'
require './test/test_data'

class InvoiceIntelligenceTest < Minitest::Test
  include TestData, TestSetup


end
