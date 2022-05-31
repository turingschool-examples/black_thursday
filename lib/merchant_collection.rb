require 'CSV'
require './lib/merchant'
class MerchantCollection

  attr_reader :all
  def initialize(file_path)
    @file_path = file_path
    @all = []

    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      @all << Merchant.new(:id => row[:id], :name => row[:name])
    end
  end

  def find_by_id(id)
    merch_name = []
    @all.each do |merchant|
      if merchant.id == id
        merch_name << merchant
      end
    end
    merch_name.first.name
  end

  def find_by_name(name)
    @all.find {|merchant| merchant.name == name}
  end

  def find_all_by_name(name)
    specific_name = []
    @all.each do |merchant|
      if merchant.name.upcase.include?(name.upcase)
        specific_name << merchant
      end
    end
    specific_name
  end

end
