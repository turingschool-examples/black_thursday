require './lib/merchant_repository'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'


class MerchantTest < Minitest::Test



#
# The MerchantRepository is responsible for
# holding and searching our Merchant instances.
# It offers the following methods:
def test_it_exists
    mr = MerchantRepository.new

    assert_instance_of MerchantRepository.new, mr
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
