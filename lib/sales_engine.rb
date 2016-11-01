require './lib/merchant_repository'
require './lib/item_repository'
require './lib/merchant'
require 'csv'

class SalesEngine

  def self.from_csv(files)
    @files = files
    self
  end
 
  def self.merchants
    merchants = merchant_csv_parse(@files[:merchants])
    MerchantRepository.new(merchants)
  end

  def self.items
    items = item_csv_parse(@files[:items])
    ItemRepository.new(items)
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
      Item.new({:id => row[:id],
                :name => row[:name],
                :description => row[:description],
                :unit_price => row[:unit_price],
                :created_at => row[:created_at],
                :updated_at => row[:updated_at],
                :merchant_id => row[:merchant_id]
              })
    end
  end

end
  