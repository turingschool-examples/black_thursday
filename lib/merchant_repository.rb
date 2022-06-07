require 'CSV'
require_relative './merchant.rb'
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
    @all.find do |merchant|
      merchant.id.to_i == id
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

  def create(attribute)
    new_id = @all.last.id.to_i + 1
    new_attribute = attribute
    @all << Merchant.new(:id => new_id.to_s, :name => new_attribute)
    return @all.last
  end

  def update(id, attributes)
    renamed_merchant = find_by_id(id)
    renamed_merchant.name = attributes
  end

  def delete(id)
    removed_merchant = find_by_id(id)
    @all.delete(removed_merchant)
  end

end
