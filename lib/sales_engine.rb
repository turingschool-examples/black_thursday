require_relative './modules/csv_adapter'

require_relative './merchant_repository'
require_relative './item_repository'
require_relative './sales_analyst'

class SalesEngine
  extend CSVAdapter

  attr_reader :merchants,
              :items,
              :analyst

  def initialize(repositories)
    @merchants = repositories[:merchants]
    @items = repositories[:items]
    @analyst = SalesAnalyst.new(self)
  end

  def self.from_csv(file_hash)
    initializers = {items: ItemRepository,
                    merchants: MerchantRepository}
    repositories = {}
    # XXX: Change to inject pattern? Maybe?
    file_hash.each do |dataset, filename|
      data = hash_from_csv(filename)
      repositories[dataset] = initializers[dataset].new(data) if initializers[dataset]
    end

    self.new(repositories)
  end
end
