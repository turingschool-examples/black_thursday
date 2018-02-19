require 'csv'
require_relative 'merchant.rb'

class MerchantRepository
  def initialize(file_path)
    @merchants = []
    load_merchants(file_path)
  end

  def all
    @merchants
  end

  def load_merchants(file_path)
    csv = CSV.foreach(file_path, headers: true, header_converters: :symbol) do |data|
      @merchants.push(Merchant.new(data))
    end
  end

  def find_by_id(id_num)
    @merchants.find do |merchant|
      merchant.id == id_num
    end
  end

  def find_by_name(merch_name)
    @merchants.find do |merchant|
      merchant.name.downcase == merch_name.downcase
    end
  end

  def find_all_by_name(string)
    @merchants.find_all do |merchant|
      merchant.name.downcase.include?(string.downcase)
    end
  end


end
