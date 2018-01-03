require_relative "test_helper"
require_relative "../lib/merchant_repo"
require_relative "../lib/sales_engine"

class MerchantRepoTest < Minitest::Test

  def test_it_exists
    se = SalesEngine.from_csv({
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv",
      :customers     => "./data/customers.csv"
    })

    mr = MerchantRepo.new(se, "./data/merchants.csv")

    assert_instance_of MerchantRepo, mr
    assert_equal 12334105, mr.merchants.first.id
    assert_equal "Shopin1901", mr.merchants.first.name
    assert_equal 475, mr.merchants.count
  end

  def test_all_returns_all_merchants
    se = SalesEngine.from_csv({
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv",
      :customers     => "./data/customers.csv"
    })

    mr = MerchantRepo.new(se, "./data/merchants.csv")

    assert_equal 475, mr.all.count
    assert_instance_of Merchant, mr.merchants.first
  end

  def test_find_by_id_finds_merchant_by_id
    se = SalesEngine.from_csv({
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv",
      :customers     => "./data/customers.csv"
    })

    mr = MerchantRepo.new(se, "./data/merchants.csv")
    expected = mr.find_by_id(12334105)

    assert_equal 12334105, expected.id
    assert_equal "Shopin1901", expected.name

    expected = mr.find_by_id(12334144)

    assert_equal 12334144, expected.id
    assert_equal "Urcase17", expected.name
  end

  def test_find_by_name_finds_merchant_by_name
    se = SalesEngine.from_csv({
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv",
      :customers     => "./data/customers.csv"
    })

    mr = MerchantRepo.new(se, "./data/merchants.csv")
    expected = mr.find_by_name("Shopin1901")

    assert_equal "Shopin1901", expected.name
    assert_equal 12334105, expected.id

    expected = mr.find_by_name("Urcase17")

    assert_equal "Urcase17", expected.name
    assert_equal 12334144, expected.id
  end

  def test_find_all_by_name_finds_all_merchants_by_name
    se = SalesEngine.from_csv({
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv",
      :customers     => "./data/customers.csv"
    })

    mr = MerchantRepo.new(se, "./data/merchants.csv")
    expected = mr.find_all_by_name("shop")

    assert_equal 26, expected.count
    assert_equal "Shopin1901", expected.first.name
    assert_equal "RanaParvaShop", expected.last.name
  end

  # def test_find_items_returns_items_sold_by_merchant_id
  #   se = SalesEngine.from_csv({
  #     :items         => "./data/items.csv",
  #     :merchants     => "./data/merchants.csv",
  #     :invoices      => "./data/invoices.csv",
  #     :invoice_items => "./data/invoice_items.csv",
  #     :transactions  => "./data/transactions.csv",
  #     :customers     => "./data/customers.csv"
  #   })
  #
  #   mr = MerchantRepo.new(se, "./data/merchants.csv")
  #   expected = mr.items(12334105)
  #
  # end
end
