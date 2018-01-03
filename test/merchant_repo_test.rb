require_relative 'test_helper'
require './lib/merchant_repo'

class MerchantRepoTest < MiniTest::Test

  def setup
    @sales_engine = SalesEngine.from_csv({
      items: 'test/fixtures/item_fixture.csv',
      merchants: 'test/fixtures/merchant_fixture.csv'
      })
    @items = @sales_engine.merchant_repo
  end

  deft

end
