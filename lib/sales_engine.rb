require 'csv'

class SalesEngine
  attr_reader :merchants, :items

  def initialize(merchants_data, items_data)
    @merchants = MerchantRepository.new(merchants_data)
    @items = ItemRepository.new(items_data)
  end

  def self.from_csv(path)
    merchants_data = load_data(path[:merchants])
    items_data = load_data(path[:items])

    SalesEngine.new(merchants_data, items_data)
  end

  def self.load_data(path)
    CSV.open(path, headers: true, header_converters: :symbol )
  end

end
