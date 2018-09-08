require 'CSV'
require 'pry'
require './lib/merchant'

class MerchantRepository

  def initialize(value_path)
    @merchants = []
    make_merchants(value_path)
  end


  def all
    @merchants
  end

  def make_merchants(value_path)
    CSV.foreach(value_path, headers: true, header_converters: :symbol) do |row|
      @merchants << Merchant.new(row)
    end
  end

end
