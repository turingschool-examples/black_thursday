require './test/test_helper'
require_relative '../lib/item_repository.rb'
require_relative '../lib/item.rb'
require_relative '../lib/sales_engine.rb'
require_relative '../lib/merchant.rb'
require_relative '../lib/merchant_repository.rb'

class ItemRepositoryTest < Minitest::Test
  def setup
    @se= SalesEngine.from_csv({
      :items     => "./data/dummy_items.csv",
      :merchants => "./data/dummy_merchants.csv",
      :invoices  => "./data/dummy_invoices.csv",
      :invoice_items => "./data/dummy_invoice_items.csv",
      :transactions =>"./data/dummy_transactions.csv",
      :customers => "./data/dummy_customers.csv" })
    @item_repo = ItemRepository.new(@se.csv_hash[:items])
    @item_repo.create_items
  end

  def test_it_exists
    assert_instance_of ItemRepository, @item_repo
  end

  def test_it_creates_items
    assert_equal [ ] , @item_repo.items
  end

  def test_all_array
    assert_equal 4, @item_repo.all.count
    assert_equal Item, @item_repo.all[0].class
  end

  def test_can_find_by_id
    assert_equal Item, @item_repo.find_by_id(263395237).class
  end

  def test_find_by_name
    assert_equal @item_repo.all[3], @item_repo.find_by_name("Free standing Woden letters")
  end

  def test_find_all_with_description
    assert_equal [@item_repo.all[1]], @item_repo.find_all_with_description("scrabble frames")
  end

  def test_find_all_by_price
    assert_equal [@item_repo.all[3]], @item_repo.find_all_by_price(7.00)
  end

  def test_find_all_by_price_range
    assert_equal 2 , @item_repo.find_all_by_price_in_range(13..14).count
  end

  def test_find_all_by_merchant_id
    assert_equal [@item_repo.all[0]], @item_repo.find_all_by_merchant_id(12334141)
  end

  def test_it_can_find_the_highest_id
    assert_equal 263396013, @item_repo.find_highest_id.id
  end

  def test_it_can_create_new_highest_id
    item = @item_repo.create_id
    assert_equal 263396014, item
  end

  def test_it_can_create
    item = @item_repo.create_id
    assert_equal 263396014, item
  end

  def test_it_can_create
    added_item = @item_repo.create(
      :id          => 3,
      :name        => "cats",
      :description => "cat frame",
      :unit_price  => 100,
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 1111)
      assert_instance_of Item, added_item[-1]
      actual = "cats"
      expected = @item_repo.all.last.name
      assert_equal expected, actual
  end

  def test_update
    original_item = @item_repo.find_by_id(263395721)
    assert_equal "Disney scrabble frames"  , original_item.name
    @item_repo.update(263395721,{:name => "Dog frame" })
    assert_equal "Dog frame", @item_repo.find_by_id(263395721).name
    assert_equal "Disney glitter frames" , @item_repo.find_by_id(263395721).description
  end

  def test_delete
    @item_repo.delete(263396013)
    assert_nil @item_repo.find_by_id(263396013)
  end
end
