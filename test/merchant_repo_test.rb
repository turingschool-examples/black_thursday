require_relative "../test/test_helper"
require_relative "../lib/merchant"
require_relative "../lib/merchant_repo"

class MerchantRepoTest < Minitest::Test

  def setup
    @mer_repo = MerchantRepo.new
  
    @mer_repo.merchants = [ 
    @merchant_1 = {id: 12334105, name: "Shopin1901", created_at: "2010-12-10", updated_at: "2011-12-04"},
    @merchant_2 = {id: 12334106, name: "Shopin1901", created_at: "2010-12-10", updated_at: "2011-12-04"},
    @merchant_3 = {id: 12334107, name: "Shopin1901", created_at: "2010-12-10", updated_at: "2011-12-04"},
    @merchant_4 = {id: 12334108, name: "Woody1901", created_at: "2010-12-10", updated_at: "2011-12-04"},
    @merchant_5 = {id: 12334109, name: "Fully1901", created_at: "2010-12-10", updated_at: "2011-12-04"},
    @merchant_6 = {id: 12334110, name: "Sleepy1901", created_at: "2010-12-10", updated_at: "2011-12-04"},
    @merchant_7 = {id: 12334111, name: "Happy1901", created_at: "2010-12-10", updated_at: "2011-12-04"},
    @merchant_8 = {id: 12334112, name: "Angry1901", created_at: "2010-12-10", updated_at: "2011-12-04"},
    @merchant_9 = {id: 12334113, name: "Turing1901", created_at: "2010-12-10", updated_at: "2011-12-04"},
    @merchant_10 = {id: 12334114, name: "Awesome1901", created_at: "2010-12-10", updated_at: "2011-12-04"}]
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
# 
  def test_it_finds_all_by_name
    assert_equal [@merchant_1, @merchant_2, @merchant_3], @mer_repo.find_all_by_name("Shopin1901")
    assert_equal [], @mer_repo.find_all_by_name("NotAngry1901")
  end
  
  def test_it_creates_attribute
    assert_instance_of Merchant, @mer_repo.create({:id => 8, :name => "Cool School"})
  end

  def test_it_updates_id
    assert_equal @merchant_10 = {id: 12334114, name: "HiThere", created_at: "2010-12-10", updated_at: "2011-12-04"}, @mer_repo.update(12334114, {:id => 2222222, :name => "HiThere"})
  end

  def test_it_deletes_merchant_by_id
    @mer_repo.delete(12334109)
    assert_equal nil, @mer_repo.find_by_id(12334109)
  end
  
end
