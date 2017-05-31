require './lib/merchant'
require 'csv'

class MerchantRepository

  attr_reader :all_merchant_data

  def initialize
    @all_merchant_data = CSV.open "./data/merchants.csv",
    headers: true, header_converters: :symbol
    all
  end

  def all
    all_merchants = Array.new
    @all_merchant_data.each do |merchant|
      all_merchants << merchant
    end
    all_merchants

  end

  # def find_by_id
  #   sanitized_merchants = @all_merchant_data.map do |merchant|
  #    puts merchant[:id]
  #
  #
  # end

  def find_by_name

  end

  def find_all_by_name

  end

end

merchant = MerchantRepository.new
