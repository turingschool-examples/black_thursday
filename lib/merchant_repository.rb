require_relative 'merchant'
require          'csv'
require          'pry'

class MerchantRepository
  attr_reader :all, :items_repo

  def initialize(all, items_repo)
    @all        = all
    @items_repo = items_repo
  end

  def find_by_id(merchant_id_inputed)
    standard_info =  merchant_id_inputed.to_s.gsub(" ", "")
    what_to_find_within_csv(:id, standard_info)
  end

  def find_by_name(merchant_name_inputed)
    standard_info = merchant_name_inputed.downcase.gsub(" ", "")
    what_to_find_within_csv(:name, standard_info)
  end

  def what_to_find_within_csv(type, standard_info)
    merchant_info = @all.find {|line| line[type].downcase  == standard_info}
    merchant_info.nil? ? merchant = nil : merchant = Merchant.new(merchant_info, items_repo)
    merchant
  end

  def find_all_by_name(merchant_name_inputed)
    standard_merchant_name = merchant_name_inputed.downcase.gsub(" ", "")
    merchant_info = @all.find_all do |line|
      line[:name].downcase.include?(standard_merchant_name)
    end
    merchants_info_on_whether_it_exist(merchant_info)
  end

  def merchants_info_on_whether_it_exist(merchant_info)
    if merchant_info.nil?
      []
    else
      merchant_info.map {|merchant_info| Merchant.new(merchant_info).name}
    end
  end
end
