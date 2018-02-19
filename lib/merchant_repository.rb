require 'csv'
require 'pry'
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
      merchant.name == merch_name
    end
  end

  def find_all_by_name(string)
    found_merchants = []
    @merchants.find_all do |merchant|
      found_merchants.push(merchant.name) if merchant.name.include?(string)
    end
    found_merchants
  end
end
