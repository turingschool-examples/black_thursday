require 'csv'
require './lib/merchantrepository'


class SalesEngine
  attr_reader :items, :merchants

  def initialize(data)
    @merchants = merchant_repo(data)
  end

  def self.from_csv(data)
    new(data)
    # @items = Item_Repository.new(CSV.read(data(:items)))
  end

  def merchant_repo(data)
    Merchant_Repository.new(merchants_creation(data))
  end

  def merchants_creation(data)
    merchant_data = CSV.open data[:merchants], headers: true, header_converters: :symbol
     merchant_data.map do |row|
      Merchant.new(row)
    end
  end


  


end