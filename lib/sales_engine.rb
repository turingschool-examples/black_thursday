require 'csv'


class SalesEngine
  attr_reader :items,
              :merchants

  def initialize(data)
    @items = data.fetch(:items)
    @merchants = data.fetch(:merchants)
  end
end

se = SalesEngine.new({
  :items     => CSV.read("./data/items.csv"),
  :merchants => CSV.read("./data/merchants.csv"),
})

se.items
mr = se.merchants
merchant = mr.find_by_name
