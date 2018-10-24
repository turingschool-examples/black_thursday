require 'pry'
require 'CSV'
require './lib/merchant'

class MerchantRepository

  attr_reader :merchants

  def initialize(csv_merchant_path)
    @merchants = []
    create_merchant(csv_merchant_path)
  end

  def create_merchant(csv_merchant_path)
    row_objects = CSV.read(csv_merchant_path, headers: true, header_converters: :symbol)
      row_objects.map do |row|
        @merchants << Merchant.new(row)
      end
  end

  def all
    @merchants.count
  end


end
