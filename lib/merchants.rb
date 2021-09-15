require 'csv'
require './lib/sales_engine'


class Merchant
  def initialize(merchants)
    @id = merchants[0]
    @name = merchants[1]
  end

  def hash_convert
    headers = []
    CSV.foreach("./data/merchants.csv", headers: true, header_converters: :symbol) do |row|
        headers << row
    end
    names = headers.map do |name|
        name[:name]
    end
  end
end
