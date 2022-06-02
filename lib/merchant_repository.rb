require 'CSV'
require './lib/merchant.rb'
class MerchantRepository
  attr_reader :all
  def initialize(file_path)
    @file_path = file_path
    @all = []

    CSV.foreach(@file_path, headers: true, header_converters: :symbol) do |row|
    @all << Merchant.new({:id => row[:id], :name => row[:name]})

    end
    
  end

  def find_by_id(id)
    @all.each do |merchant|
      if merchant.id.to_i == id
        return merchant
      else
        return nil
      end
    end
  end

  def find_by_name(name)
    @all.find do |merchant|
      merchant.name.downcase.include?(name.downcase)
    end
  end

  def find_all_by_name(name_fragment)
    @all.find_all do |merchant|
      merchant.name.downcase.include?(name_fragment.downcase)
    end
  end

end
