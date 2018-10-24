require 'csv'
require './lib/merchant'
class MerchantRepository
  attr_reader :all

  def initialize(file_path)
    @all = from_csv(file_path)
  end

  def from_csv(file_path)
    raw_merchant_data = CSV.read(file_path, {headers: true, header_converters: :symbol})
    raw_merchant_data.map do |raw_merchant|
      Merchant.new(raw_merchant.to_h)
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

  def find_all_by_name(merchant_name)
    @all.find_all do |merchant|
      merchant.name.downcase.include?(merchant_name.downcase)
    end
  end

  def create(attributes)
    highest_merchant = @all.max {|merchant| merchant.id}
    attributes[:id] = highest_merchant.id + 1
    @all << Merchant.new(attributes)
  end

  def update(id, attribute)
    merchant = find_by_id(id)
    merchant.name = attribute[:name]
  end

  def delete(id)
    merchant = find_by_id(id)
    @all.delete(merchant)
  end
end
