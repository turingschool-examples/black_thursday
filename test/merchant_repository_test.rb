require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant_repository'


class MerchantRepositoryTest < Minitest::Test
  def test_an_instance_merchant_repo_exists
    repo = MerchantRepository.new
    assert repo.instance_of?(MerchantRepository)
  end
  #
  # def test_all
  #   skip
  #   # objectsid 2,"Klein, Rempel and Jones",2012-03-27 14:53:59 UTC,2012-03-27 14:53:59 UTC
  # end
  #
  # def test_id
  #   skip
  #   # returns nil or instance of merchant with a matching id
  # end
  #
  # def test_find_by_name
  #   skip
  #   # returns nil or instance of merchant having done a case sensitive search
  # end
  #
  # def test_find_all_by_name
  #   skip
  #   # returns empty array or one or more matches which contain the supplied name fragment, case insensitive
  # end

end
