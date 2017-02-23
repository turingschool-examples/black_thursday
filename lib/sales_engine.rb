require 'pry'
require 'csv'
require './lib/merchant_repository'

class SalesEngine
  attr_reader :merchant_repo, :csv

  def initialize(file_name)
    @csv = file_name
    @merchant_repo = MerchantRepository.new(merchants)
  end

  def merchants
    CSV.open csv, headers: true, header_converters: :symbol
  end

end
