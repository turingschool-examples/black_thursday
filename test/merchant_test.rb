require './test/test_helper'
require './lib/merchant'

class MerchantTest < Minitest::Test

  def test_initialize_takes_a_hash_of_fields
    assert_instance_of Merchant, turing_school
  end

  def test_it_has_an_id
    assert_equal 5, turing_school.id
  end

  def test_it_has_a_name
    assert_equal "Turing School", turing_school.name
  end

  def turing_school
    Merchant.new({
      id: 5,
      name: "Turing School"
    })
  end

end
