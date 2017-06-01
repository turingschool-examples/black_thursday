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
    i = 0
    CSV.foreach('./data/merchants_test.csv', row_sep: :auto) do |line|
      i += 1
      next if i == 1
      mr.populate_merchants(line)
    end
    puts mr.all.inspect
  end

  def items
    ir = ItemRepository.new
    i = 0
    CSV.foreach('./data/items_test.csv', row_sep: :auto) do |line|
      i += 1
      next if i == 1
      ir.populate_items(line)
    end
    puts ir.all.inspect
  end
end

se = SalesEngine.from_csv({:items => './data/items_test.csv',
                           :merchants => './data/merchants_test.csv'})

se.merchants
se.items
