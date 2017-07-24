require 'simplecov'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant_repo'


class MerchantRepositoryTest < Minitest::Test

  def test_it_exist
    merchant_repo = Merchant_Repo.new

    assert_instance_of Merchant_Repo, merchant_repo
  end






end
