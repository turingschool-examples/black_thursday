require 'csv'
require_relative './merchant'

class MerchantRepository

  attr_accessor :merchants, :sales_engine

  def initialize(path, sales_engine)
    # @path = path
    @merchants = Hash.new
    @sales_engine = sales_engine
    populate_repository(path)
  end

  def populate_repository(path)
    data = CSV.read(path, headers: true, header_converters: :symbol)
    data.each do |merchant|
      merchants[merchant[:id].to_sym] = Merchant.new(merchant[:name], merchant[:id], sales_engine)
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
    merchants[id.to_s.to_sym]
    #  returns either nil or an instance of Merchant with a matching ID
  end

  def find_by_name(name_to_search_for)
    merchants.each do |id, merchant|
      return merchant if merchant.name.downcase == name_to_search_for.downcase
    end
    nil
    # returns either nil or an instance of Merchant having done a case insensitive search
  end

  def find_all_by_name(name_fragment)
    names = []

    merchants.each do |id, merchant|
      names << merchant if merchant.name.downcase.include?(name_fragment)
    end

    #  returns either [] or one or more matches which contain the supplied name fragment, case insensitive
    names
  end

end
