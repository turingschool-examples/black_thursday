require "csv"
require_relative "merchant"

class MerchantsRepo

  def initialize(csv_filepath)
    contents = CSV.open csv_filepath, headers: true, header_converters: :symbol
    @merchant_objects = contents.map do |row|
      Merchant.new(row)
    end
  end

  def all
    @merchant_objects
  end

  def find_by_id(merchant_id)
    merchant = find_merchant_id(merchant_id)
    if merchant != nil
      merchant.name
    else
      nil
    end
  end

  def find_merchant_id(merchant_id)
    @merchant_objects.detect do |merchant|
      merchant.id == merchant_id
    end
  end

  def find_by_name(merchant_name)
    merchant = find_merchant_name(merchant_name)
    if merchant != nil
      merchant.name
    else
      nil
    end
  end

  def find_merchant_name(merchant_name)
    @merchant_objects.detect do |merchant|
      merchant.name.upcase == merchant_name.upcase
    end
  end

  def find_all_by_name(name_fragment)
    find_all_merchants(name_fragment)
  end

  def find_all_merchants(name_fragment)
    name_fragment = name_fragment.upcase
    @merchant_objects.select do |merchant|
      merchant.name.upcase.to_s.include?(name_fragment)
    end
  end

end
