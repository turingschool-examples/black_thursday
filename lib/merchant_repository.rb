require 'csv'
require_relative 'merchant'
require 'pry'

class MerchantRepository
  attr_reader :all

  def initialize(file_path)
    @file_path = file_path
    @all = []

    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      @all << Merchant.new({:id => row[:id], :name => row[:name]})
    end
  end

  def find_by_id(id)
    @all.find do |merchant|
      if merchant.id == id
        return merchant
      end
    end
  end

  def find_by_name(name)
    @all.find do |merchant|
      if merchant.name.downcase == name.downcase
        return merchant
      end
    end
  end

  def find_all_by_name(name)
    @all.find_all do |merchant|
      if merchant.name.downcase == name.downcase
        merchant
      end
    end
  end

  def new_id
    max_id = @all.max_by do |merchant|
      merchant.id
    end
    merchant_new = max_id.id
    new_merchant_id = merchant_new + 1
  end

  def create(name)
    @all << Merchant.new({:id => new_id, :name => name})
  end


  def update(id, attributes)
    merchant = find_by_id(id)
    merchant.name = attributes[:name]

  end

  def delete(id)
    merchant = find_by_id(id)
    @all.delete(merchant)

  end
end
