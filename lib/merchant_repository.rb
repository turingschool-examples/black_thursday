require 'csv'
require_relative '../lib/merchant'
require_relative '../lib/file_opener'

class MerchantRepository
  include FileOpener
  attr_reader :merchant_data,
              :all_merchant_data

  def initialize
    all_merchants = open_csv(csv_data[:merchants])
    @all_merchant_data = all_merchants.map do |row|
      Merchant.new(row, self)
    end
  end

  def all
    @all_merchant_data
  end


end
