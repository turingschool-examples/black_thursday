require 'pry'
require 'csv'
require './lib/merchant_repository'

class SalesEngine
  attr_reader :merchant_data, :merchant_repo

  def initialize(file_name)
    @merchant_data = CSV.open file_name, headers: true, header_converters: :symbol
    @merchant_repo = MerchantRepository.new
  end

  def merchants
    merchant_data
  end
end
