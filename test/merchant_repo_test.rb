require_relative "../test/test_helper"
require_relative "../lib/merchant"
require_relative "../lib/merchant_repo"

class MerchantRepoTest < Minitest::Test

  def test_it_exists
    mer_repo = MerchantRepo.new

    assert_instance_of MerchantRepo, mer_repo
  end

  def test_it_loads_file
    mer_repo = MerchantRepo.new

    assert_equal mer_repo.merchants, mer_repo.load_file("./data/merchants.csv")
  end

  def test_it_returns_all_merchants
    mer_repo = MerchantRepo.new

    assert_equal mer_repo.merchants, mer_repo.all
  end

  def test_it_returns_merchant_by_id
    mer_repo = MerchantRepo.new
    mer_repo.load_file("./data/merchants.csv")
    assert_instance_of Merchant, mer_repo.find_by_id(12334159)
    refute_instance_of Merchant, mer_repo.find_by_id(0)
  end

  def test_it_returns_merchant_by_name
    mer_repo = MerchantRepo.new
    mer_repo.load_file("./data/merchants.csv")

    assert_instance_of Merchant, mer_repo.find_by_name("SassyStrangeArt")
    refute_instance_of Merchant, mer_repo.find_by_name("Turing School")
  end

  def test_it_finds_all_by_name
    mer_repo = MerchantRepo.new
    mer_repo.load_file("./data/merchants.csv")

    assert_instance_of Array, mer_repo.find_all_by_name("TheWoodchopDesign")
  end

  def test_it_creates_attributes
    mer_repo = MerchantRepo.new
    mer_repo.load_file("./data/merchants.csv")

    assert_equal mer_repo.merchants, mer_repo.create({:id => 5, :name => "Turing"})
  end

  def test_it_updates_id
    mer_repo = MerchantRepo.new
    mer_repo.load_file("./data/merchants.csv")

    mer_repo.update(12334105, "HiThere!")
    assert_equal "HiThere!" , mer_repo.merchants[0].name
  end

  def test_it_deletes_merchant_by_id
    mer_repo = MerchantRepo.new
    mer_repo.load_file("./data/merchants.csv")

    mer_repo.delete(12334105)

    assert_equal nil, mer_repo.find_by_id(12334105)
  end

end

# def test_it_sorts
#   mer_repo = MerchantRepo.new
#   mer_repo.load_file("./data/merchants.csv")
#   assert_instance_of Array, mer_repo.sort_them
# end
