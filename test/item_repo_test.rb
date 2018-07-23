require_relative "../test/test_helper"
require_relative "../lib/item"
require_relative "../lib/item_repo"
require "pry"

class ItemRepoTest < Minitest::Test
  
  def test_it_exists
    item_repo = ItemRepo.new

    assert_instance_of ItemRepo, item_repo
  end

  def test_it_loads_file
    item_repo = ItemRepo.new

    assert_equal item_repo.items, item_repo.load_file("./data/items.csv")
  end

  def test_it_returns_all_items
    item_repo = ItemRepo.new
    assert_equal item_repo.items, item_repo.all
  end

  def test_it_returns_items_by_id
    item_repo = ItemRepo.new
    item_repo.load_file("./data/items.csv")
    assert_instance_of Item, item_repo.find_by_id(263396013)
    refute_instance_of Item, item_repo.find_by_id(0)
  end

  def test_it_finds_by_name   #note update merchant to include find_by_name test
    item_repo = ItemRepo.new
    item_repo.load_file("./data/items.csv")

    assert_instance_of Item, item_repo.find_by_name("Green Footed Ceramic Bowl") #add name
    refute_instance_of Item, item_repo.find_by_name("heya")
  end
#make merchant find_by_name case insensitive

  def test_it_finds_all_with_description
    item_repo = ItemRepo.new
    item_repo.load_file("./data/merchants.csv")
    expected = "Magnifique toile Street Art 50x100cm réalisée avec peinture acrylique, peinture 3D, collage mosaïque, feutre Posca."
    actual = item_repo.find_all_with_description(expected)
    binding.pry
    assert_equal [expected], actual.description
  end

#   def test_it_finds_all_by_name
#     mer_repo = MerchantRepo.new
#     mer_repo.load_file("./data/merchants.csv")
#
#     assert_instance_of Array, mer_repo.find_all_by_name("TheWoodchopDesign")
#   end
#
#   def test_it_creates_attributes
#     mer_repo = MerchantRepo.new
#     mer_repo.load_file("./data/merchants.csv")
#
#     assert_equal mer_repo.merchants, mer_repo.create({:id => 5, :name => "Turing"})
#   end
#
#   def test_it_updates_id
#     mer_repo = MerchantRepo.new
#     mer_repo.load_file("./data/merchants.csv")
#
#     mer_repo.update(12334105, "HiThere!")
#     assert_equal "HiThere!" , mer_repo.merchants[0].name
#   end
#
#   def test_it_deletes_merchant_by_id
#     mer_repo = MerchantRepo.new
#     mer_repo.load_file("./data/merchants.csv")
#
#     mer_repo.delete(12334105)
#
#     assert_equal nil, mer_repo.find_by_id(12334105)
#   end
#
end

# # def test_it_sorts
# #   mer_repo = MerchantRepo.new
# #   mer_repo.load_file("./data/merchants.csv")
# #   assert_instance_of Array, mer_repo.sort_them
# # end
