require_relative "test_helper"
require_relative "../lib/item_repo"
require_relative "../lib/sales_engine"

class ItemRepoTest < Minitest::Test

  def test_it_exist
    se = SalesEngine.from_csv({
      :items         => "./test/fixtures/items_truncated.csv",
      :merchants     => "./test/fixtures/merchants_truncated.csv",
      :invoices      => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions  => "./test/fixtures/transactions_truncated.csv",
      :customers     => "./test/fixtures/customers_truncated.csv"
    })

    ir = ItemRepo.new(se, "./test/fixtures/items_truncated.csv")

    assert_instance_of ItemRepo, ir
    assert_equal 263500432, ir.items.first.id
    assert_equal "Roses/Flower Stirling Silver  Dangle Earrings", ir.items.first.name
    assert_equal 65, ir.items.count
  end

  def test_all_returns_all_items
    se = SalesEngine.from_csv({
      :items         => "./test/fixtures/items_truncated.csv",
      :merchants     => "./test/fixtures/merchants_truncated.csv",
      :invoices      => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions  => "./test/fixtures/transactions_truncated.csv",
      :customers     => "./test/fixtures/customers_truncated.csv"
    })

    ir = ItemRepo.new(se, "./test/fixtures/items_truncated.csv")

    assert_equal 65, ir.all.count
    assert_instance_of Item, ir.items.first
  end

  def test_find_by_id_finds_item_by_id
    se = SalesEngine.from_csv({
      :items         => "./test/fixtures/items_truncated.csv",
      :merchants     => "./test/fixtures/merchants_truncated.csv",
      :invoices      => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions  => "./test/fixtures/transactions_truncated.csv",
      :customers     => "./test/fixtures/customers_truncated.csv"
    })

    ir = ItemRepo.new(se, "./test/fixtures/items_truncated.csv")
    expected = ir.find_by_id(263395237)

    assert_equal 263395237, expected.id
    assert_equal "510+ RealPush Icon Set", expected.name

    expected = ir.find_by_id(263500432)

    assert_equal 263500432, expected.id
    assert_equal "Roses/Flower Stirling Silver  Dangle Earrings", expected.name
  end

  def test_find_by_name_finds_item_by_name
    se = SalesEngine.from_csv({
      :items         => "./test/fixtures/items_truncated.csv",
      :merchants     => "./test/fixtures/merchants_truncated.csv",
      :invoices      => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions  => "./test/fixtures/transactions_truncated.csv",
      :customers     => "./test/fixtures/customers_truncated.csv"
    })

    ir = ItemRepo.new(se, "./test/fixtures/items_truncated.csv")
    expected = ir.find_by_name("510+ RealPush Icon Set")

    assert_equal "510+ RealPush Icon Set", expected.name
    assert_equal 263395237, expected.id

    expected = ir.find_by_name("Roses/Flower Stirling Silver  Dangle Earrings")

    assert_equal "Roses/Flower Stirling Silver  Dangle Earrings", expected.name
    assert_equal 263500432, expected.id
  end

  def test_find_all_by_price_finds_all_items_by_name
    se = SalesEngine.from_csv({
      :items         => "./test/fixtures/items_truncated.csv",
      :merchants     => "./test/fixtures/merchants_truncated.csv",
      :invoices      => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions  => "./test/fixtures/transactions_truncated.csv",
      :customers     => "./test/fixtures/customers_truncated.csv"
    })

    ir = ItemRepo.new(se, "./test/fixtures/items_truncated.csv")
    expected = ir.find_all_by_price(0.49e2)

    assert_equal 1, expected.count
    expected.each do |item|
      assert_instance_of Item, item
    end
    assert_equal "Roses/Flower Stirling Silver  Dangle Earrings", expected.first.name
  end

  def test_it_can_find_merchant_by_merchant_id
    se = SalesEngine.from_csv({
      :items         => "./test/fixtures/items_truncated.csv",
      :merchants     => "./test/fixtures/merchants_truncated.csv",
      :invoices      => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions  => "./test/fixtures/transactions_truncated.csv",
      :customers     => "./test/fixtures/customers_truncated.csv"
    })

    ir = ItemRepo.new(se, "./test/fixtures/items_truncated.csv")
    expected = ir.find_merchant(12334141)

    assert_equal 12334141, expected.id
    assert_equal "jejum", expected.name
  end

  def test_it_can_count_items
    se = SalesEngine.from_csv({
      :items         => "./test/fixtures/items_truncated.csv",
      :merchants     => "./test/fixtures/merchants_truncated.csv",
      :invoices      => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions  => "./test/fixtures/transactions_truncated.csv",
      :customers     => "./test/fixtures/customers_truncated.csv"
    })

    ir = ItemRepo.new(se, "./test/fixtures/items_truncated.csv")
    expected = ir.items.count

    assert_equal 65, expected
  end

  def test_inspect_shortens_output
    se = SalesEngine.from_csv({
      :items         => "./test/fixtures/items_truncated.csv",
      :merchants     => "./test/fixtures/merchants_truncated.csv",
      :invoices      => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions  => "./test/fixtures/transactions_truncated.csv",
      :customers     => "./test/fixtures/customers_truncated.csv"
    })

    ir = ItemRepo.new(se, "./test/fixtures/items_truncated.csv")

    assert_equal "#<ItemRepo 65 rows>", ir.inspect
  end

  def test_find_all_with_description_finds_all_items_by_description
    se = SalesEngine.from_csv({
      :items         => "./test/fixtures/items_truncated.csv",
      :merchants     => "./test/fixtures/merchants_truncated.csv",
      :invoices      => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions  => "./test/fixtures/transactions_truncated.csv",
      :customers     => "./test/fixtures/customers_truncated.csv"
    })

    ir = ItemRepo.new(se, "./test/fixtures/items_truncated.csv")

    assert_instance_of Array, ir.find_all_with_description("shop")
    assert_equal 1, ir.find_all_with_description("shop").count
    ir.find_all_with_description("shop").each do |item|
      assert_instance_of Item, item
    end
  end

  def test_find_all_by_price_in_range_finds_all_items_in_price_range
    se = SalesEngine.from_csv({
      :items         => "./test/fixtures/items_truncated.csv",
      :merchants     => "./test/fixtures/merchants_truncated.csv",
      :invoices      => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions  => "./test/fixtures/transactions_truncated.csv",
      :customers     => "./test/fixtures/customers_truncated.csv"
    })

    ir = ItemRepo.new(se, "./test/fixtures/items_truncated.csv")

    assert_instance_of Array, ir.find_all_by_price_in_range(50..500)
    assert_equal 27, ir.find_all_by_price_in_range(50..500).count
    assert_instance_of BigDecimal, ir.find_all_by_price_in_range(50..500).first.unit_price
  end

  def test_find_items_by_merchant_id_finds_items_by_merchant_it
    se = SalesEngine.from_csv({
      :items         => "./test/fixtures/items_truncated.csv",
      :merchants     => "./test/fixtures/merchants_truncated.csv",
      :invoices      => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions  => "./test/fixtures/transactions_truncated.csv",
      :customers     => "./test/fixtures/customers_truncated.csv"
    })

    ir = ItemRepo.new(se, "./test/fixtures/items_truncated.csv")

    assert_instance_of Array, ir.find_items_by_merchant_id(12334141)
  end
end
