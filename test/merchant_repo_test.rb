require_relative "./test_helper"
#require_relative "../lib/merchant"
require_relative "../lib/merchant_repo"
require "pry"

class MerchantRepoTest < Minitest::Test

  def setup
    merchant_array = [{:id=>"12334105", :name=>"Shopin1901", :created_at=>"2010-12-10", :updated_at=>"2011-12-04"},
      {:id=>"12334112", :name=>"Candisart", :created_at=>"2009-05-30", :updated_at=>"2010-08-29"},
      {:id=>"12334113", :name=>"Sandy", :created_at=>"2010-03-30", :updated_at=>"2013-01-21"},
      {:id=>"12334115", :name=>"sandy", :created_at=>"2008-06-09", :updated_at=>"2015-04-16"},
      {:id=>"12334123", :name=>"Keckenbauer", :created_at=>"2010-07-15", :updated_at=>"2012-07-25"}]
    @mer_repo = MerchantRepo.new(merchant_array)
  end

  def test_it_exists
    assert_instance_of MerchantRepo, @mer_repo
  end

  def test_it_returns_all_merchants
    assert_equal @mer_repo.merchants, @mer_repo.all
  end

  def test_it_returns_merchant_by_id
    assert_equal @mer_repo.all[1], @mer_repo.find_by_id(12334112)
    assert_equal nil, @mer_repo.find_by_id(12345678)
  end

  def test_it_returns_merchant_by_name
    assert_equal @mer_repo.all[0], @mer_repo.find_by_name("Shopin1901")
    assert_equal nil, @mer_repo.find_by_name("NotAngry1901")
  end

  def test_it_finds_all_merchants_by_name
    assert_equal [@mer_repo.all[2], @mer_repo.all[3]], @mer_repo.find_all_by_name("Sandy")
    assert_equal [], @mer_repo.find_all_by_name("NotAngry1901")
  end

  def test_it_creates_merchant_with_attributes
    actual = @mer_repo.create({:id => 8, :name => "Cool School"})
    assert_instance_of Merchant, actual

    assert_equal "Cool School", @mer_repo.all[5].name
    refute_equal 8, @mer_repo.all[5].id
  end

  def test_it_updates_merchant_attributes
    refute_equal "HiThere", @mer_repo.all[4].name
    @mer_repo.update(12334123, {:id => 2222222, :name => "HiThere"})

    assert_equal "HiThere", @mer_repo.all[4].name
    assert_equal 12334123, @mer_repo.all[4].id
  end

  def test_it_deletes_merchant_by_id
    assert_equal 12334123, @mer_repo.all[4].id
    @mer_repo.delete(12334123)
    assert_equal nil, @mer_repo.find_by_id(12334123)
  end

end
