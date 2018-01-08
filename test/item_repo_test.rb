require_relative "test_helper"
require_relative "../lib/item_repo"
require_relative "../lib/sales_engine"

class ItemRepoTest < Minitest::Test

  def test_it_exist
    se = SalesEngine.from_csv({
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv",
      :customers     => "./data/customers.csv"
    })

    ir = ItemRepo.new(se, "./data/items.csv")

    assert_instance_of ItemRepo, ir
    assert_equal 263395237, ir.items.first.id
    assert_equal "510+ RealPush Icon Set", ir.items.first.name
    assert_equal 1367, ir.items.count
  end

  def test_all_returns_all_items
    se = SalesEngine.from_csv({
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv",
      :customers     => "./data/customers.csv"
    })

    ir = ItemRepo.new(se, "./data/items.csv")

    assert_equal 1367, ir.all.count
    assert_instance_of Item, ir.items.first
  end

  def test_find_by_id_finds_item_by_id
    se = SalesEngine.from_csv({
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv",
      :customers     => "./data/customers.csv"
    })

    ir = ItemRepo.new(se, "./data/items.csv")
    expected = ir.find_by_id(263395237)

    assert_equal 263395237, expected.id
    assert_equal "510+ RealPush Icon Set", expected.name

    expected = ir.find_by_id(263395617)

    assert_equal 263395617, expected.id
    assert_equal "Glitter scrabble frames", expected.name
  end

  def test_find_by_name_finds_item_by_name
    se = SalesEngine.from_csv({
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv",
      :customers     => "./data/customers.csv"
    })

    ir = ItemRepo.new(se, "./data/items.csv")
    expected = ir.find_by_name("510+ RealPush Icon Set")

    assert_equal "510+ RealPush Icon Set", expected.name
    assert_equal 263395237, expected.id

    expected = ir.find_by_name("Glitter scrabble frames")

    assert_equal "Glitter scrabble frames", expected.name
    assert_equal 263395617, expected.id
  end

  def test_find_all_by_price_finds_all_items_by_name
    se = SalesEngine.from_csv({
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv",
      :customers     => "./data/customers.csv"
    })

    ir = ItemRepo.new(se, "./data/items.csv")
    expected = ir.find_all_by_price(1200)

    assert_equal 2, expected.count
    expected.each do |item|
      assert_instance_of Item, item
    end
    assert_equal "The Beatles Clock | Hecho a mano", expected.first.name
    assert_equal "Abbey Road Clock | Hecho a mano", expected.last.name
  end

  def test_it_can_find_merchant_by_merchant_id
    se = SalesEngine.from_csv({
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv",
      :customers     => "./data/customers.csv"
    })

    ir = ItemRepo.new(se, "./data/items.csv")
    expected = ir.find_merchant(12334141)

    assert_equal 12334141, expected.id
    assert_equal "jejum", expected.name
  end

  def test_it_can_count_items
    se = SalesEngine.from_csv({
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv",
      :customers     => "./data/customers.csv"
    })

    ir = ItemRepo.new(se, "./data/items.csv")
    expected = ir.items.count

    assert_equal 1367, expected
  end

  def test_inspect_shortens_output
    se = SalesEngine.from_csv({
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv",
      :customers     => "./data/customers.csv"
    })

    ir = ItemRepo.new(se, "./data/items.csv")

    assert_equal "#<ItemRepo 1367 rows>", ir.inspect
  end

  def test_find_all_with_description_finds_all_items_by_description
    se = SalesEngine.from_csv({
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv",
      :customers     => "./data/customers.csv"
    })

    ir = ItemRepo.new(se, "./data/items.csv")

    assert_instance_of Array, ir.find_all_with_description("great")
    assert_equal 115, ir.find_all_with_description("great").count
    ir.find_all_with_description("great").each do |item|
      assert_instance_of Item, item
    end
  end

  def test_find_all_by_price_in_range_finds_all_items_in_price_range
    se = SalesEngine.from_csv({
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv",
      :customers     => "./data/customers.csv"
    })

    ir = ItemRepo.new(se, "./data/items.csv")

    assert_instance_of Array, ir.find_all_by_price_in_range(50..500)
    assert_equal 385, ir.find_all_by_price_in_range(50..500).count
    assert_instance_of BigDecimal, ir.find_all_by_price_in_range(50..500).first.unit_price
  end

  def test_find_all_by_merchant_id_finds_merchant_by_id
    se = SalesEngine.from_csv({
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv",
      :customers     => "./data/customers.csv"
    })

    ir = ItemRepo.new(se, "./data/items.csv")

    assert_instance_of Array, ir.find_all_by_merchant_id(50..500)
    assert_instance_of Array, ir.find_all_by_merchant_id(12334115)
    assert_instance_of String, ir.find_all_by_merchant_id(12334115).first.description
    assert_equal 263499400, ir.find_all_by_merchant_id(12334115).first.id
    assert_instance_of String, ir.find_all_by_merchant_id(12334115).first.name
    assert_equal 0.2e2, ir.find_all_by_merchant_id(12334115).first.unit_price

  end

  def test_find_items_by_merchant_id_finds_items_by_merchant_it
    se = SalesEngine.from_csv({
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv",
      :customers     => "./data/customers.csv"
    })

    ir = ItemRepo.new(se, "./data/items.csv")

    assert_instance_of Array, ir.find_items_by_merchant_id(12334141)
  end
end










