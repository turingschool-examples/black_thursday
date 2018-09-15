require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test

  def test_that_it_exists
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices => "./data/invoices.csv",
    :invoice_items => "./data/invoice_items.csv"
    })

    mr = se.merchants
    assert_instance_of MerchantRepository, mr
  end

  def test_that_it_loads_the_repository_of_merchants
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices => "./data/invoices.csv",
    :invoice_items => "./data/invoice_items.csv"
    })

    mr = se.merchants
    actual = mr.merchants_array[0]

    assert_instance_of Merchant , actual
  end

  def test_the_all_method_returns_an_array_of__all_instances_of_merchant
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices => "./data/invoices.csv",
    :invoice_items => "./data/invoice_items.csv"
    })

    mr = se.merchants
    assert_equal 475, mr.all.count
  end

  def test_the_find_by_id_method_finds_merchants_by_id
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices => "./data/invoices.csv",
    :invoice_items => "./data/invoice_items.csv"
    })

    mr = se.merchants
    findings = mr.find_by_id(12334176)
    actual = findings.name
    assert_equal 'thepurplepenshop', actual
  end

  def test_the_find_by_name_method_finds_merchants_by_name
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices => "./data/invoices.csv",
    :invoice_items => "./data/invoice_items.csv"
    })
    mr = se.merchants
    findings = mr.find_by_name("CJsDecor")
    actual = findings.id

    assert_equal 12337411, actual
  end

  def test_the_find_by_name_method_returns_nil_if_not_found
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices => "./data/invoices.csv",
    :invoice_items => "./data/invoice_items.csv"
    })
    mr = se.merchants
    actual = mr.find_by_name("Mcdonalds")

    assert_nil actual
  end

  def test_that_the_find_all_method_finds_merchants_by_fragment
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices => "./data/invoices.csv",
    :invoice_items => "./data/invoice_items.csv"
    })

    mr = se.merchants
    actual = mr.find_all_by_name("style").count

    assert_equal 3, actual
  end

  def test_the_find_by_id_method_returns_nil_if_not_found
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices => "./data/invoices.csv",
    :invoice_items => "./data/invoice_items.csv"
    })
    mr = se.merchants
    actual = mr.find_by_id(6457654)

    assert_nil actual
  end

  def test_that_create_method_creates_new_merchants
    mr = MerchantRepository.new("./data/merchants.csv")

    mr.create({name: "Turing School"})
    mr.create({name: "Mcdonalds"})
    id_number = mr.merchants_array[-1].id
    name = mr.merchants_array[-1].name

    assert_equal  12337413, id_number
    assert_equal 'Mcdonalds', name
  end

  def test_that_delete_method_deletes_merchants
    mr = MerchantRepository.new("./data/merchants.csv")

    mr.create({name: "Turing School"})
    mr.create({name: "Mcdonalds"})
    mr.delete(1)
    id_number = mr.merchants_array[-1].id
    name = mr.merchants_array[-1].name

    assert_equal 12337413, id_number
    assert_equal 'Mcdonalds', name
  end

  def test_update
    mr = MerchantRepository.new("./data/merchants.csv")
    mr.create({name: "Turing School"})
    mr.update(12337412, {:id => 1, :name => "Mcdonalds"})
    created_date = mr.merchants_array[-1].created_at
    updated_date = mr.merchants_array[-1].updated_at
    name = mr.merchants_array[-1].name
    boolean = created_date != updated_date

    assert boolean
    assert_equal 'Mcdonalds', name
  end


end
