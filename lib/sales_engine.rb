require './lib/item_repo'
require './lib/merchant_repo'
require 'CSV'
require 'pry'

class SalesEngine
  attr_reader :merchants,
              :items

  def initialize
    @merchants     = MerchantRepo.new
    @items         = ItemRepo.new
  end

  def from_csv(csv_path_info)
    # consider doing this as a CSV for each, but not sure how
    # to do this and create the merchant detail hash
    merchant_data = CSV.read(csv_path_info[:merchants], headers:true)
    header_symbols = get_header_symbols(merchant_data.headers)
    merchant_data.each do |row|
      new_merchant = create_merchant_details(row, header_symbols)
      @merchants.add_merchant(new_merchant)
    end
  end

  def create_merchant_details(merchant, header_symbols)
    merchant_details = {}
    header_symbols.each_with_index do |detail, index|
      merchant_details[detail] = merchant[index]
    end
    merchant_details
  end

  def get_header_symbols(headers)
    header_symbols = headers.map do |header|
      header.to_sym
    end
  end

end
