require "csv"

class SalesEngine

  # se = SalesEngine.from_csv({
  #   :items     => "./data/items.csv",
  #   :merchants => "./data/merchants.csv",
  # })

  def self.from_csv(argument)

    @items = []
    @items = CSV.read(argument[:items], headers: true, header_converters: :symbol)

    @merchants = []
    @merchants = CSV.read(argument[:merchants], headers: true, header_converters: :symbol)

    return {:items=> @items, :merchants=> @merchants}
  end

end
