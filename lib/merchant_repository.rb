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

  def find_all_by_name(name)
    # returns either [] or one or more matches which contain the
    # supplied name fragment, case INSENSITIVE
  end
end
