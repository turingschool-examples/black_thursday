require 'pry'
require 'csv'

class SalesEngine
  attr_reader :merchant_data

  def initialize(file_name)
    @merchant_data = CSV.open file_name, headers: true, header_converters: :symbol
  end

  def merchants
    merchant_data
  end
end
