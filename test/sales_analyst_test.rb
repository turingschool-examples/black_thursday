require './test/minitest_helper'
require './lib/sales_analyst'
require './lib/sales_engine'
require 'pry'

 class SalesAnalystTest < Minitest::Test

    def setup
     se = SalesEngine.from_csv({
     :merchants     => './test/fixtures/merchants_fixtures.csv',
     :items         => './test/fixtures/items_fixtures.csv'
                               })
     @sa = se.analyst
    end

   def test_it_exists
   assert_instance_of SalesAnalyst, @sa
   end





















 end
