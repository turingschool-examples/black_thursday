require './lib/merchant'
require 'csv'

class MerchantRepository
  attr_reader :merchant_list
  def initialize(file_path)
    @merchant_list = []
    load_csv(file_path)
  end

  def load_csv(file_path)
    CSV.foreach(file_path, headers: true, header_converters: :symbol, converters: :numeric ) do |merchant|
      @merchant_list << Merchant.new(merchant.to_h)
    end
  end

  def all
    @merchant_list
  end

  def find_by_id(id)
    merchant_list.find do |merchant|
      merchant.id == id
    end
  end

  def find_by_name(name)
    merchant_list.find do |merchant|
      merchant.name.downcase == name.downcase
    end
  end

#TODO change "name_fragment" parameter to something else
  def find_all_by_name(name_fragment)
    merchant_list.find_all do |merchant|
      merchant.name.downcase.include?(name_fragment.downcase)
    end
  end

end
