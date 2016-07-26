require './test/test_helper'
require './lib/item_repo'
class ItemRepoTest < Minitest::Test

  def test_add_items_and_access_them
    ir = ItemRepo.new
    ir.add_item({:id => 123,
                 :name => "Awesome thing",
                 :description => "It's awesome",
                 :unit_price => 1000000,
                 :merchant_id => 3,
                 :created_at => Time.now,
                 :updated_at => Time.now})
    assert_equal 1, ir.all.count
    assert_equal "Awesome thing", ir.all.first.name
  end

  def test_find_by_id
    ir = ItemRepo.new
    ir.add_item({:id => 123,
                 :name => "Awesome thing",
                 :description => "It's awesome",
                 :unit_price => 1000000,
                 :merchant_id => 3,
                 :created_at => Time.now,
                 :updated_at => Time.now})
    ir.add_item({:id => 124,
                 :name => "yarn",
                 :description => "it's yarn..."})
    assert_equal "Awesome thing", ir.find_by_id(123).name
  end

  def test_fail_at_find_by_id
    ir = ItemRepo.new
    ir.add_item({:id => 123,
                 :name => "Awesome thing",
                 :description => "It's awesome",
                 :unit_price => 1000000,
                 :merchant_id => 3,
                 :created_at => Time.now,
                 :updated_at => Time.now})
    ir.add_item({:id => 124,
                 :name => "yarn",
                 :description => "it's yarn..."})
    assert_equal nil, ir.find_by_id(0)
  end

  def test_find_by_name
    ir = ItemRepo.new
    ir.add_item({:id => 123,
                 :name => "Awesome thing",
                 :description => "It's awesome",
                 :unit_price => 1000000,
                 :merchant_id => 3,
                 :created_at => Time.now,
                 :updated_at => Time.now})
    ir.add_item({:id => 124,
                 :name => "yarn",
                 :description => "it's yarn..."})
    assert_equal 124, ir.find_by_name("YARN").id
  end

  def test_fail_at_find_by_name
    ir = ItemRepo.new
    ir.add_item({:id => 123,
                 :name => "Awesome thing",
                 :description => "It's awesome",
                 :unit_price => 1000000,
                 :merchant_id => 3,
                 :created_at => Time.now,
                 :updated_at => Time.now})
    ir.add_item({:id => 124,
                 :name => "yarn",
                 :description => "it's yarn..."})
    assert_equal nil, ir.find_by_name("carrot")
  end

  def test_find_all_with_description
    ir = ItemRepo.new
    ir.add_item({:id => 123,
                 :name => "Awesome thing",
                 :description => "It's awesome",
                 :unit_price => 1000000,
                 :merchant_id => 3,
                 :created_at => Time.now,
                 :updated_at => Time.now})
    ir.add_item({:id => 124,
                 :name => "yarn",
                 :description => "it's yarn..."})
   ir.add_item({:id => 125,
                :name => "yarn!",
                :description => "it's really cool yarn"})
    found_items = ir.find_all_with_description("yarn")
    assert_equal [], ir.find_all_with_description("foo")
    assert_equal 2, found_items.count
    assert_equal 124, found_items.first.id
  end

  def test_find_all_by_price
    ir = ItemRepo.new
    ir.add_item({:id => 123,
                 :name => "Awesome thing",
                 :description => "It's awesome",
                 :unit_price => 1000000,
                 :merchant_id => 3,
                 :created_at => Time.now,
                 :updated_at => Time.now})
    ir.add_item({:id => 124,
                 :name => "yarn",
                 :description => "it's yarn...",
                 :unit_price => 150})
    ir.add_item({:id => 125,
                :name => "yarn!",
                :description => "it's really cool yarn",
                :unit_price => 150})
    assert_equal [], ir.find_all_by_price(100)
    assert_equal 2, ir.find_all_by_price(150).count
  end

  def test_find_all_by_price_in_range
    ir = ItemRepo.new
    ir.add_item({:id => 123,
                 :name => "Awesome thing",
                 :description => "It's awesome",
                 :unit_price => 1000000,
                 :merchant_id => 3,
                 :created_at => Time.now,
                 :updated_at => Time.now})
    ir.add_item({:id => 124,
                 :name => "yarn",
                 :description => "it's yarn...",
                 :unit_price => 150})
    ir.add_item({:id => 125,
                :name => "yarn!",
                :description => "it's really cool yarn",
                :unit_price => 140})
    assert_equal [], ir.find_all_by_price_in_range((1..10))
    assert_equal 2, ir.find_all_by_price_in_range((130..150)).count
  end

  def test_find_all_by_merchant_id
    ir = ItemRepo.new
    ir.add_item({:id => 123,
                 :name => "Awesome thing",
                 :description => "It's awesome",
                 :unit_price => 1000000,
                 :merchant_id => 3,
                 :created_at => Time.now,
                 :updated_at => Time.now})
    ir.add_item({:id => 124,
                 :name => "yarn",
                 :description => "it's yarn...",
                 :unit_price => 150,
                 :merchant_id => 4})
    ir.add_item({:id => 125,
                :name => "yarn!",
                :description => "it's really cool yarn",
                :unit_price => 140,
                :merchant_id => 4})
    assert_equal [], ir.find_all_by_merchant_id(666)
    assert_equal 2, ir.find_all_by_merchant_id(4).count
  end

  def test_item_has_repo
    item_details = {:id => 2663713,
                    :name => "Jean",
                    :description => "Whatever",
                    :unit_price => 10.997,
                    :merchant_id => 5,
                    :created_at => Time.now,
                    :updated_at => Time.now}
    item_repo = ItemRepo.new
    item_repo.add_item(item_details)
    item = item_repo.all.first
    assert_equal item_repo, item.repo
  end

  def test_item_has_time_as_object
    item_details = {:id => 263396517,
                    :name => "Course contre la montre",
                    :description => "Acrylique sur toile exécutée en 2013
                    Format : 46 x 38 cm
                    Toile sur châssis en bois - non encadré
                    Artiste : Flavien Couche - Artiste côté Akoun

                    TABLEAU VENDU AVEC FACTURE ET CERTIFICAT D&#39;AUTHETICITE

                    www.flavien-couche.com",
                    :unit_price => 40000,
                    :merchant_id => 12334195,
                    :created_at => "1994-05-07 23:38:43 UTC",
                    :updated_at => "2016-01-11 11:30:35 UTC"}
    item_repo = ItemRepo.new
    item_repo.add_item(item_details)
    item = item_repo.all.first
    assert_equal DateTime, item.created_at.class
    assert_equal DateTime, item.updated_at.class
  end
end
