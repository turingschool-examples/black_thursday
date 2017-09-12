require './test/test_helper'


class MerchantRepositoryTest < Minitest::Test
  attr_reader :merchants
  def setup
    @merchants = [
      Merchant.new({id: 5, name: "Turing School"}),
      Merchant.new({id: 4, name: "Amazon"})
      Merchant.new({id: 3, name: "EmptyString"},
      Merchant.new({id: 2, name: "Amazon"}
      )
    ]
    @mr = MerchantRepository.new(merchants)
  end


  def test_that_an_instance_exits
    assert_instance_of MerchantRepository, @mr
  end

  def test_all_returns_an_array_of_all_merchant_instances
    assert_equal merchants  ,@mr.all
  end

  def test_find_by_id_returns_nil_if_no_matching_id
    assert_nil ,@mr.find_by_id(1)
  end

  def test_find_by_name_returns_merchant_instance
    assert_equal Merchant.new({id: 4, name: "Amazon"}) , @mr.find_by_id(4)
  end

  def test_find_by_name_returns_nil_if_no_match
    assert_nil, @mr.find_by_name("Happy")
  end

  def test_find_by_name_returns_matching_instance
    assert_equal Merchant.new({id: 4, name: "Amazon"}), @mr.find_by_name("Amazon")
  end

  def test_find_by_name_returns_matching_instance_no_matter_case
    assert_equal Merchant.new({id: 4, name: "Amazon"}), @mr.find_by_name("amazon")
  end

  def test_find_by_name_returns_matching_instance_with_all_caps
    assert_equal Merchant.new({id: 4, name: "Amazon"}), @mr.find_by_name("AMAZON")
  end

  def test_find_all_by_name_returns_empty_array_if_no_matches
    assert_equal [], @mr.find_all_by_name("Happy")
  end

  def test_find_all_by_name_returns_all_that_match
    expected = [Merchant.new({id: 4, name: "Amazon"}),
                Merchant.new({id: 2, name: "Amazon"})]

    assert_equal expected , @mr.find_all_by_name("Amazon")
  end

  def test_find_all_by_name_returns_all_that_match_case_insensitive
    expected = [Merchant.new({id: 4, name: "Amazon"}),
                Merchant.new({id: 2, name: "Amazon"})]

    assert_equal expected , @mr.find_all_by_name("amaZon")
  end

end
