require './lib/merchant_repository'
require './lib/merchant'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'


class MerchantTest < Minitest::Test



#
# The MerchantRepository is responsible for
# holding and searching our Merchant instances.
# It offers the following methods:
def test_it_exists
  mr = MerchantRepository.new("./data/merchants.csv")

  assert_instance_of MerchantRepository, mr
end

def test_all_returns_all_merchants_in_the_correct_format
  mr = MerchantRepository.new("./data/merchants.csv")
  merchant = Merchant.new({
    :id => 12334105,
    :name => 'Shopin1901',
    :created_at=>"2010-12-10",
    :updated_at=>"2011-12-04"
    })
  mr.all
  assert_instance_of Merchant, mr.merchants[0]
  assert_equal merchant.name, mr.merchants[0].name
  assert_equal merchant.id, mr.merchants[0].id
  assert_equal 475, mr.merchants.count
end

def test_find_by_id_returns_specified_merchant_instance
  mr = MerchantRepository.new("./data/merchants.csv")
  merchant = mr.find_by_id(12334105)
  nil_merchant = mr.find_by_id(1231412543534543)

  assert_instance_of Merchant, merchant
  assert_nil nil_merchant
end

def test_find_by_name_returns_specified_merchant_instance
  mr = MerchantRepository.new("./data/merchants.csv")
  merchant = mr.find_by_name('Shopin1901')
  nil_merchant = mr.find_by_name('Sals hammocks')
  merchant_upcase = mr.find_by_name('SHOPIN1901')

  assert_instance_of Merchant, merchant
  assert_instance_of Merchant, merchant_upcase
  assert_nil nil_merchant
end

def test_find_all_by_name_returns_an_array_with_one_or_more_matches
  mr = MerchantRepository.new("./data/merchants.csv")
  merchant = mr.find_all_by_name('little')
  nil_merchant = mr.find_all_by_name('Sals hammocks')
  merchant_upcase = mr.find_all_by_name('LITTLE')

  assert_equal 4, merchant.count
  assert_equal 4, merchant_upcase.count
  assert_equal 0, nil_merchant.count
end


# find_by_id - returns either nil or an instance of Merchant
# with a matching ID
#
# find_by_name - returns either nil or an instance of Merchant
# having done a case insensitive search
#
# find_all_by_name - returns either [] or one or more
# matches which contain the supplied name fragment, case
#   insensitive

end
