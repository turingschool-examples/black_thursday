require 'csv'

# mr = se.merchants
# merchant = mr.find_by_name("CJsDecor")

class SalesEngine

  attr_reader :items, :merchants

  def initialize(data)
    @items = data[:items]
    @merchants = data[:merchants]
  end

  def self.from_csv(info)
    SalesEngine.new({ :items => "./data/items.csv",
                      :merchants => "./data/merchants.csv"})
  end

  # def merchants
  #
  # end
  #
  def items
    csv = CSV.read(@items, headers: true, header_converters: :symbol)
     csv.map do |row|
       Item.all << Item.new(row)
    end
    Item.all
  end
end
