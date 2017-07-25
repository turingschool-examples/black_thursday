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

def test_it_can_load_a_csv
  mr = MerchantRepository.new("./data/merchants.csv")
  merchant = Merchant.new({
    :id => 12334105,
    :name => 'Shopin1901',
    :created_at=>"2010-12-10",
    :updated_at=>"2011-12-04"
    })
  mr.load_csv
  assert_equal merchant.name, mr.merchants[0].name
  assert_equal merchant.id, mr.merchants[0].id
end
# all - returns an array of all known Merchant instances
#
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
