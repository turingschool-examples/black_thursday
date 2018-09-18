require_relative 'test_helper'

require './lib/sales_engine'
require './lib/finderclass'



class FinderClassTest < MiniTest::Test

  # def test_it_exists
  #   assert_instance_of Finder, Finder
  # end

  def setup
    item_path = "./data/items.csv"
    merch_path = "./data/merchants.csv"
    @hash = { :items     => item_path, :merchants => merch_path }
    @se_csv = SalesEngine.from_csv(@hash)
    @merchants = @se_csv.merchants
    @items = @se_csv.items

    # --- Real Sample Merchants ---
    @merch1_data = {:name => "Shopin1901", :created_at => "2010-12-10", :updated_at => "2011-12-04"}
    @merch2_data = {:name => "Candisart", :created_at => "2009-05-30", :updated_at => "2010-08-29"}
    @merch1 = {:"12334105" => @merch1_data }
    @merch2 = {:"12334112" => @merch2_data}
    @merchant1 = Merchant.new( {id: 12334105, name: "Shopin1901"} )
    @merchant2 = Merchant.new( {id: 12334112, name: "Candisart"} )

    # --- Real Sample Item ---
    @item = @items.all[0]
    # NOTE - The description is only an except.
    # NOTE - DO NOT try to match the description value (@repo.all[0].description)
    @headers = [:id, :created_at, :merchant_id, :name, :description, :unit_price, :updated_at]
    # --- CSVParse created hash set ---
    @key = :"263395237"
    @value = {
              :name           => "510+ RealPush Icon Set",
              :description    => "You&#39;ve got a total socialmedia iconset!", # NOTE - excerpt!
              :unit_price     => "1200",
              :merchant_id    => "12334141",
              :created_at     => "2016-01-11 09:34:06 UTC",
              :updated_at     => "2007-06-04 21:35:10 UTC"
    }
    @expected_form_from_csv_parse = {@key => @value}
    # -----------------------------------

  end

  def test_it_finds_an_object_by_specific_column_data
    # --- Merchant Repo ---
    found = FinderClass.find_by(@merchants.all, :name, "Shopin1901")
    assert_equal @merchant1.name, found.name
    found = FinderClass.find_by(@merchants.all, :id, 12334112)
    assert_equal @merchant2.id,  found.id
    found = FinderClass.find_by(@merchants.all, :id, 12)
    assert_nil found

    # --- Item Repo ---
    found = FinderClass.find_by(@items.all, :id, 263395237)
    assert_equal @item.id, found.id
    found = FinderClass.find_by(@items.all, :name, "510+ RealPush Icon Set")
    assert_equal @item.name, found.name
    found = FinderClass.find_by(@items.all, :id, 5237)
    assert_nil found
  end

  def test_if_finds_all_objects_with_specific_column_data
    # --- Item Repo ---
    found1 = FinderClass.find_all_by(@items.all, :merchant_id, 12334105)
    found2 = FinderClass.find_all_by(@items.all, :merchant_id, 12334112)
    found3 = FinderClass.find_all_by(@items.all, :merchant_id, 12334141)
    count1 = found1.count
    count2 = found2.count
    count3 = found3.count
    assert_operator 0, :<, count1
    assert_operator 0, :<, count2
    assert_operator 0, :<, count3

    multi = count1 > 1 || count2 > 1 || count3 > 1
    assert_equal true, multi

    assert_instance_of Item, found1[0]
  end

  def test_it_can_find_max_by_column
    found = FinderClass.find_max(@merchants.all, :id)
    id1 = @merchant1.id
    id2 = @merchant2.id
    id3 = @merchants.all.last.id
    max = found.id > id1 || found.id > id2 || found.id > id3
    assert_equal true, max
  end

  def test_it_can_find_all_within_column_data_range
    # NOTE range inclusive and exclusing both give the same
    # high/low values (ie inclusive by our method)
    low = BigDecimal(100, 4)
    high = BigDecimal(200, 4)
    found = FinderClass.find_by_range(@items.all, :unit_price, (low..high))
    count = found.count
    assert_operator 0, :<, count
    object = found[4]
    assert_operator low,  :<=,  object.unit_price
    assert_operator high, :>=,  object.unit_price
    object = found.last
    assert_operator low,  :<=,  object.unit_price
    assert_operator high, :>=,  object.unit_price
  end

  def test_it_can_find_by_a_case_insensitive_search
    found1 = FinderClass.find_by_insensitive(@merchants.all, :name, "Candisart")
    found2 = FinderClass.find_by_insensitive(@merchants.all, :name, "CANDISART")
    found3 = FinderClass.find_by_insensitive(@merchants.all, :name, "CaNDiSaRT")
    found = found1 == found2 && found1 == found3
    assert_equal true, found
    assert_instance_of Merchant, found1
  end

  def test_it_can_find_by_a_case_insensitive_search
    found1 = FinderClass.find_all_by_insensitive(@merchants.all, :name, "Candisart")
    found2 = FinderClass.find_all_by_insensitive(@merchants.all, :name, "CANDISART")
    found3 = FinderClass.find_all_by_insensitive(@merchants.all, :name, "CaNDiSaRT")
    found = found1 == found2 && found1 == found3
    assert_equal true, found
    assert_instance_of Merchant, found1[0]
  end

  def test_it_can_find_all_from_a_string_fragment_of_specific_column_data
    # --- Return value ---
    found = FinderClass.find_by_fragment(@merchants.all, :name, "pi")
    assert_instance_of Array, found
    assert_instance_of Merchant, found[0]
    count = found.count
    assert_operator 0, :<, count
    # -- empty array if no match --
    found3 = FinderClass.find_by_fragment(@merchants.all, :name, "zzzzz")
    assert_equal [], found3
    # --- case insensitive --
    first  = found.first.name
    first1 = first.include?("pi")
    first2 = first.include?("PI")
    first3 = first.include?("Pi")
    first4 = first.include?("pI")
    first_found = first1 || first2 || first3 || first4
    assert_equal true, first_found

    last  = found.last.name
    last1 = last.include?("pi")
    last2 = last.include?("PI")
    last3 = last.include?("Pi")
    last4 = last.include?("pI")
    last_found = last1 || last2 || last3 || last4
    assert_equal true, last_found

    found2 = FinderClass.find_by_fragment(@merchants.all, :name, "PI")
    assert_equal found, found2
  end

  def test_it_can_group_by
    groups = FinderClass.group_by(@items.all, :merchant_id)
    assert_instance_of Hash, groups
    assert_equal 12334141, groups.keys.first
    assert_instance_of Item, groups.values.first.first
  end

end
