require_relative 'test_helper'
require_relative '../lib/find_functions'
require_relative '../lib/item_repository'

class FindFunctionsTest < Minitest::Test
  include FindFunctions
  attr_reader :all

  def setup
    @all = Minitest::Mock.new
  end

  def test_find_functions_exists_and_is_a_module
    assert Module, FindFunctions.class
  end

  def test_find_by_filters_name_method
    input = "510+ RealPush Icon Set"
    all.expect(:find, nil, [])
    find_by(:name, input)
    all.verify
  end
  
  def test_find_by_filters_id_method
    input = 10
    all.expect(:find, nil, [])
    find_by(:id, input)
    all.verify
  end

  def test_find_name_calls_all
    input = "510+ RealPush Icon Set"
    all.expect(:find, nil, [])
    find_name(input)
    all.verify
  end

  def test_find_id_calls_all
    input = 10
    all.expect(:find, nil, [])
    find_id(input)
    all.verify
  end

  def test_find_all_filters_unit_price_method
    input = 10.00
    all.expect(:find_all, nil, [])
    find_all(:unit_price, input)
    all.verify
  end
  
  def test_find_all_filters_merchant_id_method
    input = 10
    all.expect(:find_all, nil, [])
    find_all(:merchant_id, input)
    all.verify
  end
  
  def test_find_all_filters_customer_id_method
    input = 15
    all.expect(:find_all, nil, [])
    find_all(:customer_id, input)
    all.verify
  end
  
  def test_find_all_filters_status_method
    input = :pending
    all.expect(:find_all, nil, [])
    find_all(:status, input)
    all.verify
  end
  
  def test_find_all_filters_other_method
    input = "Gimley"
    all.expect(:find_all, nil, [])
    find_all(:name, input)
    all.verify
  end

  def test_equivalence_needed_evaluates_true_for_equivalence_methods
    assert equivalence_needed?(:unit_price)
    assert equivalence_needed?(:merchant_id)
    assert equivalence_needed?(:customer_id)
    assert equivalence_needed?(:status)
    refute equivalence_needed?(:name)
  end
  
  def test_find_all_equivalent_calls_all
    input = 10.00
    all.expect(:find_all, nil, [])
    find_all_equivalent(:unit_price, input)
    all.verify
    all.expect(:find_all, nil, [])
    find_all_equivalent(:merchant_id, 10)
    all.verify
  end
  
  def test_find_all_strings_calls_all
    input = "Thump Coffee"
    all.expect(:find_all, nil, [])
    find_all_strings(:name, input)
    all.verify
    all.expect(:find_all, nil, [])
    find_all_strings(:description, "handmade soap")
    all.verify
  end

end
