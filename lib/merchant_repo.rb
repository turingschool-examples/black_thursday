require 'csv'
require "pry"

class MerchantRepo
  attr_reader :merchants

  def initialize
    @merchants = []
  end

  def load_file(file_location)
    CSV.foreach(file_location, headers: true, header_converters: :symbol) do |line|
      add_merchant(line.to_h)
    end
    @merchants
  end

  def add_merchant(merchant)
    @merchants << Merchant.new(merchant)
  end

  def all
    @merchants
  end

  def find_by_id(id)
    @merchants.find do |merchant|
      merchant.id.to_i == id
    end
  end

  def find_by_name(name)
    @merchants.find do |merchant|
      merchant.name == name
    end
  end

  def find_all_by_name(name)
    @merchants.find_all do |merchant|
      merchant.name == name
    end
  end

  def create(attributes)
    merchant_new = Merchant.new(attributes)
    max_merchant = @merchants.max_by do |merchant|
      merchant.id
    end
    max_num = max_merchant.id.to_i + 1
    merchant_new.id = max_num
    @merchants << merchant_new
  end

  def update(id, attributes)
    merchant_to_change = find_by_id(id)
    merchant_to_change.name = attributes  #how are attributes passed? In what form
  end

  def delete(id)
    merchant_to_change = find_by_id(id)
    @merchants.delete(merchant_to_change)
  end
end


  # def sort_them
  #   sorted_merchants = @merchants.sort_by do |merchant|
  #     merchant.id
  #   end
  #   require "pry"; binding.pry
  # end
  # 

