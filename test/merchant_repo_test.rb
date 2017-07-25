require_relative 'test_helper'
require_relative '../lib/merchant_repo'

class MerchantRepoTest < Minitest::Test
  attr_reader :mr

  def setup
    @mr = MerchantRepo.new("./data/merchant_fixtures.csv")
  end

  def test_find_all_merchants

    assert_equal 100, mr.all.count

  end


end
