require 'csv'
require 'htmlentities'
require_relative '../lib/merchant_repository'
require_relative '../lib/merchant'
require_relative '../lib/item_repository'
require_relative '../lib/item'

class SalesEngine

  attr_reader :items, :merchants

  def from_file(data)
    insert_item_repository(data[:items])
    insert_merchant_repository(data[:merchants])
  end

  def insert_merchant_repository(file_path)
    merchants_data = parse_merchants(file_path)
    @merchants = MerchantRepository.new(merchants_data)
  end

  def insert_item_repository(file_path)
    items_data = parse_items(file_path)
    @items = ItemRepository.new(items_data)
  end

  def parse_merchants(file_path)
    merchants_data = []
    CSV.foreach(file_path, headers:true) do |row|
      merchants_data << Merchant.new({:id => row['id'].to_i, 
                                      :name => row['name']})
    end
    merchants_data
  end

  def parse_items(file_path)
    items_data = []
    CSV.foreach(file_path, headers:true) do |row|
      items_data << Item.new({:id => row['id'].to_i, 
                              :name => row['name'],
                              :description => HTMLEntities.new.decode(row['description']),
                              :unit_price => BigDecimal.new(row['unit_price']),
                              :merchant_id => row['merchant_id'],
                              :created_at => Time.parse(row['updated_at']),
                              :updated_at => Time.parse(row['created_at'])
                            })
    end
    items_data
  end

end