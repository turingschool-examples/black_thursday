require_relative 'merchant'
require          'csv'
require          'pry'


class MerchantRepository
  attr_reader :all

  def initialize(all)
    @all = all
  end

  def find_by_id(merchant_id_inputed)
    standard_merchant_id =  merchant_id_inputed.to_s.gsub(" ", "")
    merchant_info = @all.find {|line| line[:id]  == standard_merchant_id}
    merchant_info.nil? ? merchant = nil : merchant = Merchant.new(merchant_info)
    merchant
  end

  def find_by_name(merchant_name_inputed)
    standard_merchant_name = merchant_name_inputed.downcase.gsub(" ", "")
    merchant_info = @all.find {|line| line[:name].downcase  == standard_merchant_name}
    merchant_info.nil? ? merchant = nil : merchant = Merchant.new(merchant_info)
    merchant
  end

  def find_all_by_name(merchant_name_inputed)
    standard_merchant_name = merchant_name_inputed.downcase.gsub(" ", "")
    merchant_info = @all.find_all do |line|
      line[:name].downcase.include?(standard_merchant_name)
    end
    if merchant_info.nil?
      []
    else
      merchant_info.map {|merchant_info| Merchant.new(merchant_info).name}
    end
  end
end

# se = SalesEngine.from_csv({:items => "./data/items.csv", :merchants => "./data/merchants.csv"})

# se = SalesEngine.from_csv({
#   :items     => "./data/items.csv",
#   :merchants => "./data/merchants.csv",
# })
#
# mr = se.merchants
# merchant = mr.find_by_name("CJsDecor")
