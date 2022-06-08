require 'csv'
require_relative 'merchant'
require_relative 'inspector'

class MerchantRepository
  include Inspector
  attr_reader :all

  def initialize(file_path)
    @file_path = file_path
    @all = []

    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      @all << Merchant.new({:id => row[:id].to_i, :name => row[:name]})
    end
  end

  def find_by_id(merchant_id_search)
    @all.find do |merchant|
      merchant.id == merchant_id_search
    end
  end

  def find_by_name(merchant_name_search)
    @all.find do |merchant|
      merchant.name.downcase == merchant_name_search.downcase
    end
  end

  def find_all_by_name(name_fragment_search)
    @all.find_all do |merchant|
      merchant.name.downcase.include?("#{name_fragment_search.downcase}")
    end
  end

  def create(new_merchant)
    max_id = @all.max do |merchant|
      merchant.id
    end
    new_merchant[:id] = max_id.id + 1
    @all << Merchant.new(new_merchant)
  end

  def update(merchant_id_search, new_name)
    @all.find do |merchant|
      merchant.id == merchant_id_search
      merchant.name = new_name
    end
  end

  def delete(merchant_id_search)
    @all.each do |merchant|
      if merchant.id == merchant_id_search
        @all.delete(merchant)
      end
    end
  end
end
