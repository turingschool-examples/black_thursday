require "csv"
class SalesEngine
  attr_accessor :merchants,
                :items
  def initialize
    @merchants = nil
    @items = nil
  end

  def self.from_csv(repos)
    se = SalesEngine.new
    merchant_repository = se.pull_merchant_repository(repos[:merchants])
    item_repository = se.pull_item_repository(repos[:items])

    se.merchants = merchant_repository
   se.items = item_repository
   return se
  end

  def pull_merchant_repository(file_path_merchant)
    mr = MerchantRepository.new
    total_merchants = CSV.read(file_path_merchant, headers: true, header_converters: :symbol)
    total_merchants.each do |merchant|
      m = Merchant.new({:id => merchant[:id], :name => merchant[:name]})
      mr.add_merchant(m)
    end
    return mr
  end

  def pull_item_repository(file_path_item)
    it = ItemRepository.new
    total_items = CSV.read(file_path_item, headers: true, header_converters: :symbol)
    total_itmes.each do |item|
      i = Item.new({:id => item[:id], :name => item[:name], :description => item[:description],
                    :unit_price => item[:unit_price], :created_at => item[:created_at],
                    :updated_at => item[:updated_at], :merchant_id => item[:merchant_id]})
      it.add_item(1)
    end 
  end
end
