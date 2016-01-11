require 'pry'
require 'csv'

class MerchantRepository

  def initialize

  end


  def all
  end

  def load_data(filename)
    contents = CSV.open filename, headers: true, header_converters: :symbol
    # contents.each do |row|
    #   name = row[:name]
    #   puts name
    # end
  end


end

mr = MerchantRepository.new
merchant_list = mr.load_data('../data/merchants.csv')
puts merchant_list
