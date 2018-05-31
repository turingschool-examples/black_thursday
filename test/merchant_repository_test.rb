require './test_helper'
require './lib/merchant'
require './lib/merchant_repository'
require './lib/file_loader'
require './lib/sales_engine'
require 'pry'

class MerchantRepositoryTest < MiniTest::Test
  include FileLoader
  def test_it_exists
    se = SalesEngine.from_csv({
      :items => "./data/item_sample.csv",
      :merchants => "./data/merchant_sample.csv",
      :invoices => "./data/invoices.csv"
    })
    mr = se.merchants

    assert_instance_of MerchantRepository, mr
  end

  def test_merchants_starts_as_an_empty_array
    se = SalesEngine.from_csv({
      :items => "./data/item_sample.csv",
      :merchants => "./data/merchant_sample.csv",
      :invoices => "./data/invoices.csv"
    })
    mr = se.merchants

    assert_instance_of Array, mr.all
  end

  def test_it_can_create_merchants
    se = SalesEngine.from_csv({
     :items => "./data/item_sample.csv",
     :merchants => "./data/merchant_sample.csv",
     :invoices => "./data/invoices.csv"
    })
    mr = se.merchants
    attributes = {:name => 'Turing School', :created_at => "2018-04-25", :updated_at => "2018-05-25"}
    mr.create(attributes)

    assert_equal 12334123, mr.all[-2].id
    assert_equal 12334124, mr.all[-1].id
    assert_equal 'Turing School', mr.all.last.name
  end

  def test_it_can_return_merchant_by_its_id
    se = SalesEngine.from_csv({
      :items => "./data/item_sample.csv",
      :merchants => "./data/merchant_sample.csv",
      :invoices => "./data/invoices.csv"
    })
    mr = se.merchants
    attributes_1 = {:name => 'Turing School', :created_at => '2018-04-25', :updated_at => '2018-05-25'}
    merchant_1 = mr.create(attributes_1)
    attributes_2 = {:id => 8, :name => 'Apple', :created_at => '2018-04-25', :updated_at => '2018-05-25'}
    merchant_2 = mr.create(attributes_2)

    assert_equal merchant_1, mr.find_by_id(12334124)
    assert_equal merchant_2, mr.find_by_id(12334125)
  end

  def test_it_returns_nil_if_merchant_id_is_not_present
    se = SalesEngine.from_csv({
      :items => "./data/item_sample.csv",
      :merchants => "./data/merchant_sample.csv",
      :invoices => "./data/invoices.csv"
    })
    mr = se.merchants
    attributes_1 = {:name => 'Turing School', :created_at => '2018-04-25', :updated_at => '2018-05-25'}
    merchant_1 = mr.create(attributes_1)
    attributes_2 = {:id => 8, :name => 'Apple', :created_at => '2018-04-25', :updated_at => '2018-05-25'}
    merchant_2 = mr.create(attributes_2)

    assert_nil mr.find_by_id(12334130)
  end

  def test_it_can_return_merchant_by_its_name
    se = SalesEngine.from_csv({
      :items => "./data/item_sample.csv",
      :merchants => "./data/merchant_sample.csv",
      :invoices => "./data/invoices.csv"
    })
    mr = se.merchants
    attributes_1 = {:name => 'Turing School', :created_at => '2018-04-25', :updated_at => '2018-05-25'}
    merchant_1 = mr.create(attributes_1)
    attributes_2 = {:id => 8, :name => 'Apple', :created_at => '2018-04-25', :updated_at => '2018-05-25'}
    merchant_2 = mr.create(attributes_2)

    assert_equal merchant_1, mr.find_by_name('Turing School')
    assert_equal merchant_2, mr.find_by_name('Apple')
  end

  def test_it_returns_nil_if_merchant_name_is_not_present
    se = SalesEngine.from_csv({
      :items => "./data/item_sample.csv",
      :merchants => "./data/merchant_sample.csv",
      :invoices => "./data/invoices.csv"
    })
    mr = se.merchants
    attributes_1 = {:name => 'Turing School', :created_at => '2018-04-25', :updated_at => '2018-05-25'}
    merchant_1 = mr.create(attributes_1)
    attributes_2 = {:id => 8, :name => 'Apple', :created_at => '2018-04-25', :updated_at => '2018-05-25'}
    merchant_2 = mr.create(attributes_2)

    assert_nil mr.find_by_name('Google')
  end

  def test_it_returns_array_of_merchants_by_their_name
    se = SalesEngine.from_csv({
      :items => "./data/item_sample.csv",
      :merchants => "./data/merchant_sample.csv",
      :invoices => "./data/invoices.csv"
    })
    mr = se.merchants
    attributes_1 = {:name => 'Turing School', :created_at => '2018-04-25', :updated_at => '2018-05-25'}
    merchant_1 = mr.create(attributes_1)
    attributes_2 = {:id => 8, :name => 'Apple School', :created_at => '2018-04-25', :updated_at => '2018-05-25'}
    merchant_2 = mr.create(attributes_2)
    attributes_3 = {:id => 4, :name => 'Microsoft', :created_at => '2018-04-25', :updated_at => '2018-05-25'}
    merchant_3 = mr.create(attributes_3)

    assert_equal [merchant_1, merchant_2], mr.find_all_by_name('Sch')
    assert_equal [merchant_3], mr.find_all_by_name('ros')
    assert_equal [], mr.find_all_by_name('Galvanize')
  end

  def test_merchant_name_can_be_updated_and_records_date_of_update
    se = SalesEngine.from_csv({
      :items => "./data/item_sample.csv",
      :merchants => "./data/merchant_sample.csv",
      :invoices => "./data/invoices.csv"
    })
    mr = se.merchants
    new_attributes_1 = {:name => 'The Basement'}
    new_attributes_2 = {:name => 'Samsung'}
    new_attributes_3 = {:name => 'Xbox'}
    mr.update(12334105, new_attributes_1)
    mr.update(12334112, new_attributes_2)
    mr.update(12334113, new_attributes_3)
    todays_date = Date.today.strftime("%Y-%m-%e")

    assert_equal 'The Basement', mr.collection[12334105].name
    assert_equal 'Samsung', mr.collection[12334112].name
    assert_equal 'Xbox', mr.collection[12334113].name
    assert_equal todays_date, mr.collection[12334105].updated_at
    assert_equal todays_date, mr.collection[12334112].updated_at
    assert_equal todays_date, mr.collection[12334113].updated_at

    assert_nil mr.update(1234567876543212345, new_attributes_1)
  end

  def test_merchant_can_be_deleted_by_id
    se = SalesEngine.from_csv({
      :items => "./data/item_sample.csv",
      :merchants => "./data/merchant_sample.csv",
      :invoices => "./data/invoices.csv"
    })
    mr = se.merchants
    attributes_1 = {:name => 'Turing School', :created_at => '2018-04-25', :updated_at => '2018-05-25'}
    merchant_1 = mr.create(attributes_1)

    assert_equal merchant_1, mr.find_by_id(12334124)

    mr.delete(12334124)

    assert_nil mr.find_by_id(12334124)
  end
end
