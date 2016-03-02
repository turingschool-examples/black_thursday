require 'minitest/autorun'
require 'minitest/pride'
require 'csv'
require 'time'
require 'bigdecimal'
require 'pry'
require_relative '../lib/item_repository'
require_relative '../sales_engine'

class ItemRepositoryTest < Minitest::Test

  def setup
    se = SalesEngine.from_csv({:items => './test/fixtures/items_fixture.csv'})
    @ir = se.items
  end

  def test_initalize_organizes_row_values
     
  end

end
