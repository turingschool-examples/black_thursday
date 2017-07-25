require 'csv'
require 'pry'
require './lib/item_repository'
require './lib/merchant_repository'

class SalesEngine

  attr_reader :mr

  def initialize
    @array = []
    @items = ItemRepository.new
    @mr = MerchantRepository.new
  end

  def from_csv(input)
    input.each_pair do |key, value|
      load_csv(value, key)
    end
  end

  def open_csv(path)
    row = CSV.open path, headers: true, header_converters: :symbol
    row.each do |data|
    # # @merchants.add_data(data)
    #   # binding.pry
    #   array << data.to_h
    # binding.pry
    @mr.add_data(data.to_hash)
        puts data.inspect
        # puts "\n\n END DATA \n\n"
    end
  end





end

se = SalesEngine.new
se.open_csv("./data/merchants_short.csv")
binding.pry
