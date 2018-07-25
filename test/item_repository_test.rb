require 'minitest/autorun'
require 'minitest/pride'
require_relative './item_repository.rb'
require_relative './item.rb'
require_relative './sales_engine.rb'
require_relative './merchant.rb'
require_relative './merchant_repository.rb'
require 'pry'

class ItemRepositoryTest < Minitest::Test
  def setup
    @se = SalesEngine.from_csv({
      :items     => "./data/dummy_items.csv",
      :merchants => "./data/dummy_merchants.csv"
      })


  end

  def test_it_exists
    se = SalesEngine.from_csv({
      :items     => "./data/dummy_items.csv",
      :merchants => "./data/dummy_merchants.csv"
      })
    ir = ItemRepository.new(se.csv_hash[:items])
    assert_instance_of ItemRepository, ir
  end

  def test_it_creates_items
    se = SalesEngine.from_csv({
      :items     => "./data/dummy_items.csv",
      :merchants => "./data/dummy_merchants.csv"
      })
    ir = ItemRepository.new(se.csv_hash[:items])
    assert_equal [ ] , ir.items
  end

  def test_all_array
    se = SalesEngine.from_csv({
      :items     => "./data/dummy_items.csv",
      :merchants => "./data/dummy_merchants.csv"
      })
    ir = ItemRepository.new(se.csv_hash[:items])
    assert_equal [ ], ir.all
  end

  def test_can_find_by_id
    se = SalesEngine.from_csv({
      :items     => "./data/dummy_items.csv",
      :merchants => "./data/dummy_merchants.csv"
      })
    ir = ItemRepository.new(se.csv_hash[:items])
    ir.create_items
    assert_equal Item, ir.find_by_id("263395237").class
  end

  def test_find_by_name
    se = SalesEngine.from_csv({
      :items     => "./data/dummy_items.csv",
      :merchants => "./data/dummy_merchants.csv"
      })
    ir = ItemRepository.new(se.csv_hash[:items])
    ir.create_items
    assert_equal ir.all[3], ir.find_by_name("Free standing Woden letters")
#when i run this there are brackets that switch if i put brackets around both they pass?
  end

  def test_find_all_with_description
    se = SalesEngine.from_csv({
      :items     => "./data/dummy_items.csv",
      :merchants => "./data/dummy_merchants.csv"
      })
    ir = ItemRepository.new(se.csv_hash[:items])
    ir.create_items
    assert_equal [ir.all[1]], ir.find_all_with_description("scrabble frames")
    #should i use items or all?
  end

    def test_find_all_by_price
      se = SalesEngine.from_csv({
        :items     => "./data/dummy_items.csv",
        :merchants => "./data/dummy_merchants.csv"
        })
      ir = ItemRepository.new(se.csv_hash[:items])
      ir.create_items
    #  ir.all.convert_unit_price_to_dollar_string
      assert_equal [ir.all[3]], ir.find_all_by_price("700")
    end

    def test_find_all_by_price_range

      se = SalesEngine.from_csv({
        :items     => "./data/dummy_items.csv",
        :merchants => "./data/dummy_merchants.csv"
        })
      ir = ItemRepository.new(se.csv_hash[:items])
      ir.create_items
      #ir.convert_unit_price_to_dollar_string
      assert_equal 2 , ir.find_all_by_price_in_range(1300..1400).count
    end

    def test_find_all_by_merchant_id
      se = SalesEngine.from_csv({
        :items     => "./data/dummy_items.csv",
        :merchants => "./data/dummy_merchants.csv"
        })
      ir = ItemRepository.new(se.csv_hash[:items])
      ir.create_items
      assert_equal [ir.all[0]], ir.find_all_by_merchant_id("12334141")
    end

    def test_it_can_create_new_id
      se = SalesEngine.from_csv({
        :items     => "./data/dummy_items.csv",
        :merchants => "./data/dummy_merchants.csv"
      })
      ir = ItemRepository.new(se.csv_hash[:items])
      ir.create_items
      item = ir.create_id
      assert_equal 263396014, item
  end
    def test_it_can_create
      se = SalesEngine.from_csv({
        :items     => "./data/dummy_items.csv",
        :merchants => "./data/dummy_merchants.csv"
        })
      ir = ItemRepository.new(se.csv_hash[:items])
      ir.create_items
      added_item = ir.create(
        :id          => 3,
        :name        => "cats",
        :description => "cat frame",
        :unit_price  => 100,
        :created_at  => Time.now,
        :updated_at  => Time.now,
        :merchant_id => 1111)
        assert_instance_of Item, added_item[-1]
        actual = "cats"
        expected = ir.all.last.name
        assert_equal expected, actual
    end

    def test_update
      se = SalesEngine.from_csv({
        :items     => "./data/dummy_items.csv",
        :merchants => "./data/dummy_merchants.csv"
      })
      ir = ItemRepository.new(se.csv_hash[:items])
      ir.create_items
      original_item = ir.find_by_id("263395721")
      assert_equal "Disney scrabble frames"  , original_item.name
      ir.update("263395721",{:name => "Dog frame" })
      assert_equal "Dog frame", ir.find_by_id("263395721").name
      assert_equal "Disney glitter frames" , ir.find_by_id("263395721").description
      #refute_equal original_item.updated_at, ir.find_by_id("263395721").updated_at
    end

    def test_delete
      se = SalesEngine.from_csv({
        :items     => "./data/dummy_items.csv",
        :merchants => "./data/dummy_merchants.csv"
      })
      ir = ItemRepository.new(se.csv_hash[:items])
      ir.create_items
      ir.delete("263396013")
      assert_nil ir.find_by_id("263396013")
    end


end
