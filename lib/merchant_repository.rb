require './lib/merchant'
require 'csv'

class MerchantRepository
  attr_reader :merchants,
              :name,
              :id

  def initialize(parent)
    @merchants = []
    @sales_engine = parent
  end

  def all
    @merchants
  end

  def find_by_id(id)
    @merchants.find{|merchant|  merchant.id == id}
  end

  def create_merchant(data)
      CSV.foreach  data[:merchants], headers: true, header_converters:
      :symbol do |row|
        @merchants << Merchant.new(row, self)
      end
  end

  # def items
  #   @merchants.find_all{|mer|item}
  # end

  def find_by_name(name)
    @merchants.find{|merchant| merchant.name == name}
  end

  def find_all_by_name(name)
    @merchants.find_all{|merchant| merchant.name == name}
  end



#   all - returns an array of all known Merchant instances
# find_by_id - returns either nil or an instance of Merchant with a matching ID
# find_by_name - returns either nil or an instance of Merchant having done a case insensitive search
# find_all_by_name

end
