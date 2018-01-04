require 'CSV'
require_relative '../lib/merchant'

class MerchantRepository
  # do we need contents as attr_reader
  attr_reader :all

  def initialize(file_path)
    contents = CSV.open(file_path, headers: true, header_converters: :symbol)
    @all = contents.map do |row|
      Merchant.new({:id => row[:id], :name => row[:name]})
    end
  end

  def find_by_id(id)
    all.find do |merchant|
      merchant.id == id
    end
  end

  def find_by_name(name)
    all.find do |merchant|
      merchant.name.downcase == name.downcase
    end
  end

  def find_all_by_name(name_fragment)
    all.select do |merchant|
      merchant.name.downcase.include?(name_fragment.downcase)
    end
  end

end
