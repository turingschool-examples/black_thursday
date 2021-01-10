require 'minitest/autorun'
require 'minitest/pride'
require './lib/item_repo'
require './lib/cleaner'
require 'mocha/minitest'

class ItemRepositoryTest < Minitest::Test

  def setup
    @item_repository = ItemRepository.new("repo")
    @cleaner = Cleaner.new
  end

  def test_it_exists
    assert_instance_of ItemRepository, @item_repository
  end

  def test_it_returns_all_items
    assert_equal 1367, @item_repository.all.length
  end

  def test_it_can_find_by_id
      assert_equal 263538760, @item_repository.find_by_id(263538760).id
      assert_equal "Puppy blankie", @item_repository.find_by_id(263538760).name
      assert_nil @item_repository.find_by_id(1)
  end

  def test_item_objects
    assert_equal 1367, @item_repository.items.length
    assert_equal "Free standing Woden letters", @item_repository.items[3].name
  end

  def test_it_finds_item_by_name
    assert_equal "Puppy blankie", @item_repository.find_by_name("Puppy blankie").name
    assert_equal 263538760, @item_repository.find_by_name("Puppy blankie").id
    assert_nil @item_repository.find_by_name("SalesEngine")
  end

  def test_it_finds_all_with_description
    expected = "A large Yeti of sorts, casually devours a cow as the others watch numbly."
    assert_equal expected, @item_repository.find_all_with_description(expected)[0].description
    assert_equal 263550472, @item_repository.find_all_with_description(expected).first.id

    bad_case = "A LARGE yeti of SOrtS, casually devoURS a COw as the OTHERS WaTch NUmbly."
    assert_equal expected, @item_repository.find_all_with_description(bad_case)[0].description
    assert_equal 263550472, @item_repository.find_all_with_description(expected).first.id

    description = "Sales Engine is a relational database"
    assert_equal 0, @item_repository.find_all_with_description(description).length
  end

  def test_it_finds_all_by_price
    assert_equal 79, @item_repository.find_all_by_price(BigDecimal.new(25)).length
    assert_equal 63, @item_repository.find_all_by_price(BigDecimal.new(10)).length
    assert_equal 0, @item_repository.find_all_by_price(BigDecimal.new(20000)).length
  end

  def test_it_can_find_by_price_in_range
      range = (1000.00..1500.00)
      assert_equal 19, @item_repository.find_all_by_price_in_range(range).length

      range2 = (10.00..150.00)
      assert_equal 910, @item_repository.find_all_by_price_in_range(range2).length

      range3 = (10.00..15.00)
      assert_equal 205, @item_repository.find_all_by_price_in_range(range3).length

      range4 = (0..10.0)
      assert_equal 302, @item_repository.find_all_by_price_in_range(range4).length
  end

  def test_it_can_find_all_by_merchant_id
      merchant_id = 12334326
      assert_equal 6, @item_repository.find_all_by_merchant_id(merchant_id).length

      merchant_id_2 = 12336020
      assert_equal 2, @item_repository.find_all_by_merchant_id(merchant_id_2).length
  end

  def test_it_can_create_a_new_item
    attributes = {
      name: "Capita Defenders of Awesome 2018",
      description: "This board both rips and shreds",
      unit_price: BigDecimal.new(399.99, 5),
      created_at: Time.now,
      updated_at: Time.now,
      merchant_id: 25
    }
    @item_repository.create(attributes)
    assert_equal "Capita Defenders of Awesome 2018", @item_repository.find_by_id(263567475).name
  end

  def test_it_can_sort_by_id
    assert_equal 263395237, @item_repository.sort_by_id[0].id
    assert_equal 263395617, @item_repository.sort_by_id[1].id
    assert_equal 263395721, @item_repository.sort_by_id[2].id
  end


  def test_update
    attributes = {
      name: "Capita Defenders of Awesome 2018",
      description: "This board both rips and shreds",
      unit_price: BigDecimal.new(399.99, 5),
      created_at: Time.now,
      updated_at: Time.now,
      merchant_id: 25
    }

    updated_attribute_hash = {
      :name => "Bleeps",
      :description => "doop doop doop",
      :unit_price => BigDecimal.new(599.99, 5)
    }

    # updated_time = mock()
    # updated_time.stubs(:updated_at).returns(2021-01-07 18:03:23 -0700)
    # allow(Time).to receive(:now).and_return(@time_now)
    # Time.stubs(:now).returns(Time.mktime(1970,1,1))

    @item_repository.create(attributes)
    assert_equal 263567475, @item_repository.find_by_name("Capita Defenders of Awesome 2018").id

    @item_repository.update(263567475, updated_attribute_hash)
    assert_equal 263567475, @item_repository.find_by_name("Bleeps").id

    #assert_equal mock_time, @item_repository.find_by_name("Bleeps").updated_at
  end

  def test_it_deletes_items
    attributes = {
      name: "Capita Defenders of Awesome 2018",
      description: "This board both rips and shreds",
      unit_price: BigDecimal.new(399.99, 5),
      created_at: Time.now,
      updated_at: Time.now,
      merchant_id: 25
    }

    @item_repository.create(attributes)
    assert_equal "Capita Defenders of Awesome 2018", @item_repository.find_by_id(263567475).name
    assert_equal 1368, @item_repository.items.length

    @item_repository.delete(263567475)
    assert_nil @item_repository.find_by_id(263567475)
    assert_equal 1367, @item_repository.items.length

    @item_repository.delete(263538760)
    assert_nil @item_repository.find_by_id(263538760)
    assert_equal 1366, @item_repository.items.length
  end

  def test_it_can_find_merchant_id
    assert_equal 263396209, @item_repository.find_by_merchant_id(12334105)[0].id
  end
end
