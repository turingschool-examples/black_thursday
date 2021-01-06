require './lib/merchant'
require './lib/sales_engine'
require 'csv'

class MerchantRepository
  attr_reader :merchants,
              :path

def initialize(path)
  @path = path
  @merchants = []
  read_merchant
end

def read_merchant
  CSV.foreach(@path, headers: :true , header_converters: :symbol) do |row|
     # ;binding.pry

    # Merchant.new(row)

    @merchants << Merchant.new(row)


  # first_row = CSV.read(locations) do |line|
  # rows.map do |row|

    end
    return @merchants
  end

  def all
    @merchants
  end  
end
