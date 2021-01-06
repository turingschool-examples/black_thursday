require 'csv'
require 'pry'
class SalesEngine
  attr_reader :merchants,
              :items

  def initialize(locations)
    @merchants = MerchantRepository.new(locations[:merchants])
    @items = ItemRepository.new(locations[:items])
  end

  def self.from_csv(locations)
    SalesEngine.new(locations)
  end

  # def read_merchant(locations)
  #   CSV.foreach(locations[:merchants], headers: :true , header_converters: :symbol) do |row|
  #      # ;binding.pry
  #
  #     # Merchant.new(row)
  #
  #     @merchants << Merchant.new(row)
  #
  #
  #   # first_row = CSV.read(locations) do |line|
  #   # rows.map do |row|
  #
  #   end
  #   ;binding.pry
  #   return @merchants
  #
  # end

  def all
    puts @merchants
  end

end
