require 'pry'
require '../lib/merchant'
require '../lib/merchant_repository'

@sample = [{:id => 12334105, :name => "Shopin1901", :created_at => "2010-12-10", :updated_at => "2011-12-04" }, {:id => 12334112, :name => "Candisart", :created_at => "2009-05-30", :updated_at => "2010-08-29"}]

@merchant_1 = Merchant.new(@sample[0])

@merchant_2 = Merchant.new(@sample[1])

@merchant_1_inspect = "id:12334105,\nname: Shopin1901,\ncreated_at: 2010-12-10,\nupdated_at: 2011-12-04"

@merchant_2_inspect = "id:12334112,\nname: Candisart,\ncreated_at: 2009-05-30,\nupdated_at: 2010-08-29"

mr = MerchantRepository.new(@sample)
mr.find_by_name("Shopin1901")

mr.find_by_name("Candisart")
