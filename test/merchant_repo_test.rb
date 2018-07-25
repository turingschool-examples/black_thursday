require_relative "../test/test_helper"
require_relative "../lib/merchant"
require_relative "../lib/merchant_repo"

class MerchantRepoTest < Minitest::Test

  def setup
    @mer_repo = MerchantRepo.new(merchants)

    @mer_repo.merchants = [
    @merchant_1 = Merchant.new({id: 12334105, name: "Shopin1901"}),
    @merchant_2 = Merchant.new({id: 12334106, name: "Shopin1901"}),
    @merchant_3 = Merchant.new({id: 12334107, name: "Shopin1901"}),
    @merchant_4 = Merchant.new({id: 12334108, name: "Woody1901"}),
    @merchant_5 = Merchant.new({id: 12334109, name: "Fully1901"}),
    @merchant_6 = Merchant.new({id: 12334110, name: "Sleepy1901"}),
    @merchant_7 = Merchant.new({id: 12334111, name: "Happy1901"}),
    @merchant_8 = Merchant.new({id: 12334112, name: "Angry1901"}),
    @merchant_9 = Merchant.new({id: 12334113, name: "Turing1901"}),
    @merchant_10 = Merchant.new({id: 12334114, name: "Awesome1901"})
  ]
  end

  def test_it_exists
    assert_instance_of MerchantRepo, @mer_repo
  end

  def test_it_returns_all_merchants
    assert_equal @mer_repo.merchants, @mer_repo.all
  end

  def test_it_returns_merchant_by_id
    assert_equal @merchant_1, @mer_repo.find_by_id(12334105)
    assert_equal nil, @mer_repo.find_by_id(12345678)
  end

  def test_it_returns_merchant_by_name
    assert_equal @merchant_8, @mer_repo.find_by_name("Angry1901")
    assert_equal nil, @mer_repo.find_by_name("NotAngry1901")
  end

  def test_it_finds_all_merchants_by_name
    assert_equal [@merchant_1, @merchant_2, @merchant_3], @mer_repo.find_all_by_name("Shopin1901")
    assert_equal [], @mer_repo.find_all_by_name("NotAngry1901")
  end

  def test_it_creates_merchant_with_attributes
    assert_instance_of Merchant, @mer_repo.create({:id => 8, :name => "Cool School"})
  end

  def test_it_updates_merchant_attributes
    refute_equal "HiThere", @merchant_10.name

    @mer_repo.update(12334114, {:id => 2222222, :name => "HiThere"})

    assert_equal "HiThere", @merchant_10.name
    assert_equal 12334114, @merchant_10.id
  end

  def test_it_deletes_merchant_by_id
    @mer_repo.delete(12334109)
    assert_equal nil, @mer_repo.find_by_id(12334109)
  end

end
