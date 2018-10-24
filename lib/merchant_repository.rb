require 'pry'
require 'CSV'
require './lib/merchant'

class MerchantRepository

  attr_reader :merchants

  def initialize(csv_merchants)
    @merchants = []
    create_merchant(csv_merchants)
  end

  def create_merchant(csv_merchants)
    row_objects = CSV.read(csv_merchants, headers: true, header_converters: :symbol)
      row_objects.map do |row|
        @merchants << Merchant.new(row)
      end
  end

  def all
    @merchants.count
  end


end
