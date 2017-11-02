require './lib/merchant'
require './lib/sales_engine'
require 'csv'

class MerchantRepository
  attr_reader :merchants,
              :parent

  def initialize(parent, filename)
    @merchants      = []
    @parent         = parent
    @load           = load_file(filename)
  end

  def load_file(filename)
    merchant_csv = CSV.open filename,
                             headers: true,
                             header_converters: :symbol
    merchant_csv.each do |row| @merchants << Merchant.new(row, self) end
  end

  def all
    #returns an array of all known Merchant instances
    @merchants
  end

  def find_by_id(id)
    #returns either nil or an instance of Merchant with a matching ID
      @merchants.find { |merchant| merchant.id == id.to_s}
  end

  def find_by_name(name)
    #returns either nil or an instance of Merchant having done a case insensitive search
      @merchants.find { |merchant| merchant.name.downcase == name.downcase }
  end

  def find_all_by_name(name)
    #returns either [] or one or more matches which contain the supplied name fragment, case insensitive
    @merchants.find_all do |merchant|
      merchant.name.downcase.include?(name.downcase)
    end
  end
end
