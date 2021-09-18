require 'csv'
require './lib/merchantrepository'
require './lib/itemrepository'

class SalesEngine

  attr_reader :items, :merchants

  def initialize(data)
    @items     = data[:items]
    @merchants = data[:merchants]
  end

  def self.from_csv(info)
    SalesEngine.new({ :items => "./data/items.csv",
                      :merchants => "./data/merchants.csv"})
  end

  def merchants
    @rows = CSV.table(@merchants, headers: true).by_row
    MerchantRepository.new = []
    MerchantRepository << @rows
    MerchantRepository
    # ({
    #                         id: @id,
    #                         name: @name,
    #                         created_at: @created_at,
    #                         updated_at: @updated_at
    #                         })


  end
  #
  def items
    all = []

    csv = CSV.read(@items, headers: true, header_converters: :symbol)
     csv.map do |row|
       all << Item.new(row)
    end
   ItemRepository.new(all)

  end
end
