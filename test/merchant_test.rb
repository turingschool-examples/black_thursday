require 'minitest/autorun'
require 'minitest/emoji'
require 'mocha'

require './black_thursday/lib/merchant_repository'

class MerchantTest < Minitest::Test

  attr_reader :merchant

  def setup
    @merchant = MerchantRepository.new('./black_thursday/test/fixtures/merchants_truncated.csv').merchants[:"12334112"]
  end

  def test_it_exists
    assert merchant
  end

  def test_it_knows_its_items
    item1 = mock("item")
    item2 = mock("item")

    merchant.add_items([item1, item2])
    assert_include
  end
end