require 'csv'
require_relative 'merchant_repository'
require_relative 'item_repository'

class SalesEngine
  attr_reader :files
  def initialize(files)
    @files = files
  end

  # def initialize(params = {})
  #   @items_file = params.fetch(:items, "")
  #   @merchants_file = params.fetch(:merchants, "")
  # end

  def self.from_csv(files)
    # merchant_library = CSV.open(files[:merchants]), headers: true
    # items_library = CSV.open(files[:items]), headers: true
    SalesEngine.new(files)
  end

  def merchants
    mr = MerchantRepository.new
    lines = File.readlines @files[:merchants], headers: true
    lines.each do |line|
      mr.populate_merchants(line)
    end
    puts mr.all.inspect
  end

  def items(items_library)
    ir = ItemRepository.new
  end
end

se = SalesEngine.from_csv({:items => './data/items_test.csv',
                           :merchants => './data/merchants_test.csv'})

se.merchants
