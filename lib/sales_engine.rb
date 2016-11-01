require './lib/merchant_repository'
require './lib/item_repository'
require './lib/merchant'
require 'csv'

class SalesEngine

  def self.from_csv(files)
    @merchant_repo = create_merchant_repository(files)
    @item_repo = create_item_repository(files)
    self
  end

  def self.create_merchant_repository(files)
    if files.include?(:merchants)
      MerchantRepository.new(merchant_csv_parse(files[:merchants]))
    end
  end

  def self.create_item_repository(files)
    if files.include?(:items)
      ItemRepository.new(item_csv_parse(files[:items]))
    end
  end

  def self.merchants
    @merchant_repo
  end

  def self.items
    @item_repo
  end

  def self.merchant_csv_parse(file)
    contents = CSV.open file, headers: true, header_converters: :symbol
    contents.map do |row|
      Merchant.new({:id => row[:id], :name => row[:name]})
    end
  end

  def self.item_csv_parse(file)
    contents = CSV.open file, headers: true, header_converters: :symbol
    contents.map do |row|
      Item.new({:name => row[:name],
                :description => row[:description],
                :unit_price => row[:unit_price],
                :created_at => row[:created_at],
                :updated_at => row[:updated_at],
              })
    end
  end

end