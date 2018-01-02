require_relative "test_helper"
require_relative "../lib/merchant_repository"

class MerchantRepositoryTest < Minitest::Test

  def test_it_exists
    mr = MerchantRepository.new('./test/test_data/test_merchants.csv')

    assert_instance_of MerchantRepository, mr
  end

  def test_contents_are_csv_object
    mr = MerchantRepository.new('./test/test_data/test_merchants.csv')

    assert_instance_of CSV, mr.contents
  end

  def test_contents_are_accessible_by_headers
    mr = MerchantRepository.new('./test/test_data/test_merchants.csv')

    ids = mr.contents.map do |row|
      id = row[:id]
    end

    assert_equal ["12334105", "12334112", "12334113", "12334113", "12334123"], ids
  end

end
