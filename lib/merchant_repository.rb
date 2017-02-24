require_relative 'merchant'

class MerchantRepository
  attr_reader :merchant_data, :all

  def initialize(merchant_data)
    @merchant_data = merchant_data
    @all = create_merchants
    require "pry"; binding.pry
  end

  def create_merchants
    merchant_data.map do |row|
      Merchant.new(row)
    end
  end

  # def find_by_id(id)
  #
  # end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end
