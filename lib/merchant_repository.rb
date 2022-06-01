require 'csv'
require_relative 'merchant'

class MerchantRepository
  attr_reader :all

  def initialize(file_path)
    @file_path = file_path
    @all = []

    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      @all << Merchant.new({:id => row[:id], :name => row[:name]})
    end
  end

  def find_by_id(merchant_id)
    @all.find do |merchant|
      merchant.id == merchant_id
    end
  end

  def find_by_name(merchant_name)
    @all.find do |merchant|
      merchant.name.downcase == merchant_name.downcase
    end
  end

  def find_all_by_name(name_fragment)
    @all.find_all do |merchant|
      merchant.name.downcase.include?("#{name_fragment.downcase}")
    end
  end

end
