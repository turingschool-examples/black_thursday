require './test/test_helper'
require 'minitest/mock'
require './lib/item_repo'

class ItemRepoTest < Minitest::Test
  def test_it_exists
    skip
    data = CSV.open './data/items.csv', headers: true, header_converters: :symbol
    data = [{name: "string",
                id: "string",
                description: "string",
                unit_price: "string",
                created_at: Time.now.to_s,
                updated_at: Time.now.to_s,
                merchant_id: "string"}]
    se = def find_merchant_by_id
    "merchant"
    end
    assert ItemRepo.new(data, se)
  end

  def test_it_has_merchant
    data = [{name: "string",
                id: "string",
                description: "string",
                unit_price: "string",
                created_at: Time.now.to_s,
                updated_at: Time.now.to_s,
                merchant_id: "merchant_id"}]
    mock_se = MiniTest::Mock.new
    # mock expects:
    #            method      return  arguments
    #-------------------------------------------------------------
    mock_se.expect(:find_merchant_by_id, "merchant", ["merchant_id"])

    item_repo = ItemRepo.new(data, mock_se)
    assert_equal "merchant", item_repo.find_merchant_by_id("merchant_id")
    assert mock_se.verify

  end
end
