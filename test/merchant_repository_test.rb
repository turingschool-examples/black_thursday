require_relative 'test_helper'
require_relative '../lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test

  # def setup
  #   @mr = MerchantRepository.new('./data/merchants.csv')
  # end

  def test_can_create_a_repo_of_merchants
    #mr = MerchantRepository.new('./data/merchants.csv')
    csv_object_of_merchants = CSV.open './data/merchants.csv', headers: true, header_converters: :symbol
    mr = MerchantRepository.new(csv_object_of_merchants)
    #see that we're getting a full array of all merchants
    assert_equal 475, mr.all.count
    assert_equal 12334105, mr.all[0].id
  end

  def test_parse_merchants

  end

  def test_all_merchants

  end

  # def test_merchant_instance_can_be_created
  #   skip
  #   merchant_1 = mock('name_one')
  #   merchant_2 = mock('name_two')
  #   expected = ['name_one', 'name_two']
  #   submitted = @mr.all
  #
  #   assert_equal expected, submitted
  # end
  #
  # def test_it_can_load_the_merchant_csv_file
  #   skip
  #   load_file = './data/merchant.csv'
  #   submitted = @mr.load_data(load_file)
  #
  #   assert_equal load_file, submitted
  # end
  #
  # def test_merchant_can_be_found_by_id
  #   skip
  #   id = 12334105
  #   submitted = @mr.parse_data(id)
  #
  #   assert_equal id, submitted
  # end
  #
  # def test_merchant_can_return_nil_when_searched_by_id
  #   skip
  #   id = 12334104
  #   submitted = @mr.parse_data(id)
  #
  #   # assert_nil submitted
  #   assert_equal "nil", submitted
  # end
  #
  # def test_merchant_can_be_found_by_name
  #   skip
  #   submitted = @mr.find_name()
  #
  # end
  #
  # def test_merchant_can_return_nil_when_searched_by_name
  #   skip
  #   submitted = @mr.find_name()
  # end

end
