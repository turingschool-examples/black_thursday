require_relative 'merchant'
require 'pry'

class MerchantRepository
  attr_reader :merchant_repo

  def initialize(csv_file)
    @merchant_repo = csv_file.map do |merchant|
      Merchant.new(merchant)
    end
  end

  def all
    @merchant_repo
  end

  
end
