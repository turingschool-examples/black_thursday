require 'csv'

class SalesEngine
  attr_reader :items, :merchants

  def initialize(items, merchants)
    @items = items
    @merchants = merchants
  end

  def self.from_csv(csv_hash)
    items_contents = CSV.open(csv_hash[:items], headers: true, header_converters: :symbol)
    merchants_contents = CSV.open(csv_hash[:merchants], headers: true, header_converters: :symbol)
    sales_engine = SalesEngine.new(items_contents, merchants_contents)
  end

  def items
    item_repository
  end
  
  # def merchants
  #   mr = MerchantRepository.new
  #   @merchants.each do |merchant|
  #     mr.add({id: merchant[:id], name: merchant[:name]})
  #   end
  #   mr
  # end
end