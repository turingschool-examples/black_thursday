require_relative 'test_helper.rb'
require_relative '../lib/sales_engine.rb'
# require_relative '../lib/merchantrepository'
# require_relative '../lib/merchant'
# require_relative '../lib/item_repository.rb'
require_relative '../lib/sales_analyst'

require 'csv'
class SalesAnalystTest < Minitest::Test
  def test_it_exists
    sales_analyst = SalesAnalyst.new
    assert_instance_of SalesAnalyst, sales_analyst
  end

  
end
