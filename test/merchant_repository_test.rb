require './test/test_helper'
require './lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test
  def setup
    file_name   = "./data/sample_data/merchants.csv"
    @merch_repo = MerchantRepository.new(file_name)
  end

  def test_merchant_repository_class_exists
    assert_instance_of MerchantRepository, @merch_repo
  end

  def test_all_method
    assert_instance_of Array, @merch_repo.all
    assert_instance_of Merchant, @merch_repo.all.first
    assert_equal '12334105', @merch_repo.all.first.id
    assert_equal 'LolaMarleys', @merch_repo.all.last.name
  end

  def test_find_by_id_method
    assert_nil @merch_repo.find_by_id('8')
#   or an instance of Merchant with a matching ID
    assert_instance_of Merchant, @merch_repo.find_by_id('12334105')
  end

  def test_find_by_name
#   find_by_name - returns either nil
    skip
    assert_nil @merch_repo.find_by_name('Satisfaction')
#   or an instance of Merchant having done
#   a case insensitive search
    assert_instance_of Merchant, @merch_repo.find_by_name('LolaMarleys')
  end

  def test_find_all_by_name
#   find_all_by_name - returns either [] or one or more matches
    skip
    assert_nil @merch_repo.find_all_by_name('Bullets')
#   which contain the supplied name fragment, case insensitive
    # assert_equal , @merch_repo.find_all_by_name('ar')
  end
end
