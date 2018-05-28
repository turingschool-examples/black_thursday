require_relative 'sales_engine'

class MerchantRepository
attr_reader :merchants
# The MerchantRepository is responsible for holding and searching our Merchant instances.

  def initialize(merchants)
    @merchants = merchants
     #takes in hash
  end

  def all
    merchant_objects = []
    @merchants.each do |merchant|
      merchant_objects << Merchant.new(merchant)
    end
    merchant_objects
  end

  def find_by_id(id)
    # returns either nil or an instance of Merchant with a matching ID
  end

  def find_by_name(name)
    # returns either nil or an instance of Merchant having done a case insensitive search
  end

  def find_all_by_name(name)
    # returns either [] or one or more matches which contain the supplied name fragment, case insensitive
  end

  def create(attributes)
    # create a new Merchant instance with the provided attributes. The new Merchant’s id should be the current highest Merchant id plus 1.
  end

  def update_id(id, attributes)
    # update the Merchant instance with the corresponding id with the provided attributes. Only the merchant’s name attribute can be updated.
  end

  def delete(id)
    # delete the Merchant instance with the corresponding id. The data can be found in data/merchants.csv so the instance is created and used like this:
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end


# '12334105,Shopin1901,2010-12-10,2011-12-04'
#
# {12334105: {id:'12334105',
#             name:'Shopin1901',
#             created_at:'2010-12-10',
#             updated_at:'2011-12-04'}
# }
