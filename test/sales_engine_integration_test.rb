require 'pry'
require 'minitest/autorun'
require 'minitest/pride'

require_relative '../lib/merchant'
require_relative '../lib/merchant_repository'
require_relative '../lib/item'
require_relative '../lib/item_repository'
require_relative '../lib/sales_engine'

class SalesEngineTest < Minitest::Test
  def setup
    @sales_engine = SalesEngine.new
    @merchant_1_inspect = "id: 12334105,\nname: Shopin1901,\ncreated_at: 2010-12-10,\nupdated_at: 2011-12-04"
    @merchant_2_inspect = "id: 12334112,\nname: Candisart,\ncreated_at: 2009-05-30,\nupdated_at: 2010-08-29"
    @merchant_1_inspect_find_all = "[id: 12334105,\nname: Shopin1901,\ncreated_at: 2010-12-10,\nupdated_at: 2011-12-04]"

  end

  def test_can_load_file
    file = SalesEngine.load_file('data/items.csv')
    assert file
  end

  def test_items_can_be_loaded_into_repository
    @items = ItemRepository.new(@sales_engine)
    file = SalesEngine.load_file('data/items.csv')
    @sales_engine.load_items_into_repository(@sales_engine, file)
    assert_equal 1367, @sales_engine.items.repository.count
  end

  def test_merchants_can_be_loaded_into_repository
    @merchants = MerchantRepository.new(@sales_engine)
    file = SalesEngine.load_file('data/merchants.csv')
    @sales_engine.load_merchants_into_repository(@sales_engine, file)
    assert_equal 475, @sales_engine.merchants.repository.count
  end

  def test_from_csv_will_create_Sales_Engine_object_and_add_files_into_repositories
    se = SalesEngine.from_csv({
      :items     => "data/items.csv",
      :merchants => "data/merchants.csv",
      :invoices => 'data/invoices.csv'
      })
    assert_equal 1367, se.items.repository.count
    assert_equal 475, se.merchants.repository.count
    mr = se.merchants

    assert_equal @merchant_2_inspect, mr.find_by_name("candIsArt").inspect
    assert_equal nil, mr.find_by_name("Girls Rule the World Shop")

    ir = se.items

    assert_equal '  id: 263398179
    name: Le corps et la chauffeuse
    description: Acrylique sur toile exécutée en 2011
Format : 65 x 54 cm
Toile sur châssis en bois - non encadré
Artiste : Flavien Couche - Artiste côté Akoun

TABLEAU VENDU AVEC FACTURE ET CERTIFICAT D&#39;AUTHETICITE

www.flavien-couche.com
    unit price: 0.5E3
    merchant id: 12334195
    created at: 2016-01-11 11:30:34 UTC
    updated at: 2007-01-06 13:55:19 UTC', ir.find_by_id(263398179).inspect


  end



end
