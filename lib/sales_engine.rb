require 'csv'
require_relative '../lib/item'
require_relative '../lib/item_repository'
require_relative '../lib/merchant'
require_relative '../lib/merchant_repository'


class SalesEngine
  attr_reader :items, :merchants

  def initialize
    @items = ItemRepository.new
    @merchants = MerchantRepository.new
  end

  def self.from_csv(loadpath_hash)
    items = load_file(loadpath_hash[:items])
    merchants = load_file(loadpath_hash[:merchants])
    sales_engine = SalesEngine.new

    sales_engine.load_items_into_repository(items)
    sales_engine.load_merchants_into_repository(merchants)




    sales_engine
  end

  def self.load_file(loadpath)
    contents = CSV.open "#{loadpath}", headers: true, header_converters: :symbol
  end

  def load_items_into_repository(items)
    items.each do |row|
      @items.repository << Item.new({:id =>row[:id],
                         :name => row[:name],
                         :description => row[:description],
                         :unit_price => row[:unit_price],
                         :merchant_id => row[:merchant_id],
                         :created_at => row[:created_at],
                         :updated_at => row[:updated_at]})
    end

  end

  def load_merchants_into_repository(merchants)
    merchants.each do |row|
      @merchants.repository << Merchant.new({:id => row[:id],
                                             :name => row[:name],
                                             :created_at => row[:created_at],
                                             :updated_at => row[:updated_at]})
    end
  end

  end
