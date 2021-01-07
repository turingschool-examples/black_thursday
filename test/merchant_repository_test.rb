require_relative './test_helper'
require './lib/merchant'
require './lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test
  def test_it_exists_and_has_attributes
    m_repo = MerchantRepository.new("./data/merchants.csv", "engine")

    assert_instance_of MerchantRepository, m_repo
    assert_equal false, m_repo.all.nil?
  end

  def test_it_can_find_merchants
    m_repo = MerchantRepository.new("./data/merchants.csv", "engine")
    m_repo.create({name: "Turing"})
    instance_1 = m_repo.all.last

    assert_equal instance_1, m_repo.find_by_id("12337412")
  end
end
