require 'csv'

class SalesEngine

  attr_reader :items,
              :merchants

  def self.from_csv(hash)
    @items = CSV.open(hash[:items], headers: true, header_converters: :symbol)
    @merchants = CSV.open(hash[:merchants], headers: true, header_converters: :symbol)
  end

end
