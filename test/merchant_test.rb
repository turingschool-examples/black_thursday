require "./test/test_helper"
require "./lib/merchant"


class MerchantTest < Minitest::Test

  attr_reader :merchant

  def setup
    csv_hash = {id: 5.0,
                name: "Turing School",
                created_at: "2016-01-11 09:34:06 UTC",
                updated_at: "2007-06-04 21:35:10 UTC"
               }
    @merchant = Merchant.new('mr', csv_hash)
  end

  def test_it_exists
    assert_instance_of Merchant, merchant
  end

  def test_id_is_returned
    assert_equal 5, merchant.id
  end

  def test_id_is_integer
    assert_equal 5, merchant.id
  end

  def test_name_is_returned
    assert_equal "Turing School", merchant.name
  end

  def test_it_has_created_at_time
    assert_equal Time.parse("2016-01-11 09:34:06 UTC"), merchant.created_at
  end

  def test_it_has_updated_at_time
    assert_equal Time.parse("2007-06-04 21:35:10 UTC"), merchant.updated_at
  end
end
