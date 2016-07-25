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

  def find_by_id(merch_id)
    # binding.pry
    @merchant_objects.select do |merchant|
      if merchant.include?(merch_id)
      end
    end
  end

end
