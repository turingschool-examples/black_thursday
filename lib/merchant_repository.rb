require 'csv'
require_relative './merchant'

class MerchantRepository

  attr_accessor :merchants

  def initialize(path)
    # @path = path
    @merchants = Hash.new
    populate_repository(path)
  end

  def populate_repository(path)
    data = CSV.read(path, headers: true, header_converters: :symbol)
    data.each do |merchant|
      merchants[merchant[:id].to_sym] = Merchant.new(merchant[:name], merchant[:id])
    end
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

  def all
    all_merchants = []
    merchants.each do |merch_id, merchant|
      all_merchants << merchant
    end
    all_merchants
  end

  def find_by_id(id)

    #  returns either nil or an instance of Merchant with a matching ID
  end

  def find_by_name(name)

    # returns either nil or an instance of Merchant having done a case insensitive search
  end

  def find_all_by_name

    #  returns either [] or one or more matches which contain the supplied name fragment, case insensitive

  end

end
