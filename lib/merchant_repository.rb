require 'pry'
require 'csv'
require_relative 'merchant'

class MerchantRepository

  def initialize(merchants)
    parse_merchants(merchants)
  end

  def parse_merchants(merchants)
    @merchant_array = []
    merchants.each do |row|
      @id = row[:id]
      @name = row[:name]
      # merchants = Hash[:id, @id, :name, @name]

      @merchant_array << Merchant.new({:id => @id}, {:name => @name})
    end
    puts @merchant_array[0]
    puts @merchant_array[0].id
    puts @merchant_array[0].name
  end

  def all
    @merchant_array
  end

  def find_by_name(merchant_name)

  end

end

if __FILE__ == $0
# mr = MerchantRepository.new('./data/merchants.csv')
# merchant_list = mr.load_data('./data/merchants.csv')
# mr.find_id(12334105)
# puts mr.parse_data(12334105)
end
