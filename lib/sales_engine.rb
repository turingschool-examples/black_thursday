require 'csv'
require './lib/merchant_repository'
require './lib/item_repository'
require './lib/merchant'

class SalesEngine
  attr_reader :merchants, :items

  def initialize(merchant_repository, item_repository)
    @merchants = merchant_repository
    @items = item_repository
  end

  def self.from_csv(file_paths)
    mr = MerchantRepository.new
    ir = ItemRepository.new
    merchants = self.parse_merchants(mr, file_paths[:merchants])
    items = self.parse_items(ir, file_paths[:items])
    SalesEngine.new(merchants, items)
  end

  def self.parse_merchants(mr, file_path)
    skip_first_line = true
    CSV.foreach(file_path) do |row|
      unless skip_first_line
        mr.add_merchant(Merchant.new({:id => row[0].to_i, :name => row[1]}))
      else
        skip_first_line = false
      end
    end
    mr
  end

  def self.parse_items(ir, file_path)
    CSV.foreach(file_path) do |row|
      binding.pry
      ir.add_item(Merchant.new({:id => row[0].to_i, :name => row[1]}))
    end
    ir
  end

  # def parse_merchants(merchant_path)
  #   merchants = []
  #   CSV.foreach(merchant_path) do |row|
  #     binding.pry
  #     merchants << (Merchant.new({:id => row[0].to_i, :name => row[1]}))
  #   end
  #   merchants
  # end

end
