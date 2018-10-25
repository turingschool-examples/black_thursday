require 'csv'
require_relative './merchant_repository'
require_relative './item_repository'
require_relative './merchant'
require_relative './item'
require_relative './sales_analyst'

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

  def analyst
    SalesAnalyst.new({merchants: @merchants, items: @items})
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
    skip_first_line = true
    CSV.foreach(file_path) do |row|
      unless skip_first_line
        ir.add_item(Item.new({:id => row[0].to_i, :name => row[1],
              :description => row[2], :unit_price => BigDecimal.new(row[3].to_f,4),
              :created_at => row[5], :updated_at => row[6],
              :merchant_id => row[4].to_i}))
      else
        skip_first_line = false
      end
    end
    ir
  end

end
