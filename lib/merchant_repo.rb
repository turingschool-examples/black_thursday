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
    merchant_id = merchant_id.to_i
    merchant = find_merchant_id(merchant_id)
    if merchant != nil
      merchant
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
      merchant
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
    @merchant_objects.select do |merchant|
      merchant.name.upcase.include?(name_fragment.upcase)
    end
  end


end
