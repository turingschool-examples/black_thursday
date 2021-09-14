require 'csv'
require './lib/sales_engine'


class MerchantRepository < SalesEngine
  # attr_reader :@@filename
  @@filename = './data/merchants.csv'

  # def initialize
  # end

  def all
    result = []
    CSV.foreach(@@filename, headers: true) do |row|
      result << row.to_hash
    end
    result
  end
end
