require 'pry'
require 'csv'
require_relative '../lib/merchant'
require_relative '../lib/file_opener'

class MerchantRepository
  include FileOpener
  attr_reader :all_merchant_data,
              :sales_engine,
              :all

  def initialize(csv_data, sales_engine)
    @sales_engine = sales_engine
    @all_merchant_data = open_csv(csv_data)
    @all = @all_merchant_data.map do |row|
      Merchant.new(row)
    end
  end

end
