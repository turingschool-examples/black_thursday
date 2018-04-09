# frozen_string_literal: true

require './test/test_helper'
require './lib/merchant_repository'
require './lib/merchant'
require './lib/loader'
# Merchant Repository Test
class MerchantRepositoryTest < Minitest::Test
  attr_reader :parent,
              :merchant_repo
  def setup
    file_path = './test/fixtures/merchant_fixtures.csv'
    # contents = Runner.load(file_path)
    @merchant_repo = MerchantRepository.new(file_path)
    # @parent = Minitest::mock.new(contents, parent)
  end

  def test_it_exists
    assert_instance_of MerchantRepository, @merchant_repo
  end

  def test_contents_data_type
skip
    assert_equal Array, @merchant_repo.csv_data.class
  end

  def test_items_data_type
skip
    assert_equal 5, @merchant_repo.all.count
  end

  def test_find_by_id
skip
    result = '3,Mariah,Toy,2012-03-27 14:54:10 UTC,2012-03-27 14:54:10 UTC'

    assert_equal result, @merchant_repo.find_by_id(3).id
  end
end
