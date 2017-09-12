# require_relative 'merchant_repository'
# require_relative 'item_repository'


class SalesEngine

  def self.from_csv(filenames)
    csvs = filenames.transform_values do |filename|
      CSV.foreach(filename).map do |row|
        row.to_hash
      end
    end
  end

  attr_reader :items, :merchants
  def initialize(tables)
    @items = ItemRepository.new(tables[:items]) if tables[:items]
    @merchants = MerchantRepository.new(tables[:merchants]) if tables[:merchants]
  end

end
