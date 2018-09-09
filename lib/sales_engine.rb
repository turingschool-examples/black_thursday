require_relative './modules/csv_adapter'

require_relative './merchant_repository'
require_relative './item_repository'

class SalesEngine
  extend CSVAdapter

  attr_reader :merchants,
              :items

  def initialize(repositories)
    @merchants = repositories[:merchants]
    @items = repositories[:items]
  end

  def self.from_csv(files)
    initializers = {items: ItemRepository,
                    merchants: MerchantRepository}
    repositories = {}
    
    # TODO: Change to inject pattern? Maybe?
    files.each do |dataset, filename|
      data = hash_from_csv(filename)
      repositories[dataset] = initializers[dataset].new(data)
    end

    self.new(repositories)
  end
end
