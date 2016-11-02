require 'csv'
require './lib/merchant_repo'

class Merchant
  attr_reader :id,
              :name,
              :created_at,
              :updated_at

  def initialize(data)
    data = CSV.open "./data/merchants.csv", headers: true, header_converters: :symbol

    data.each do |row|
      @id = row[0]
      @name = row[1]
      @created_at = row[2]
      @updated_at = row[3]
    end
  end
end

m = Merchant.new({:id => 5, :name => "Turing School"})

  puts m.id

  puts m.name

  puts m.created_at

  puts m.updated_at
