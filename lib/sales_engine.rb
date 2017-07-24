require 'pry'
class SalesEngine
  attr_reader :items,
              :merchants
  def from_csv(hash)
    @items = hash[:items]
    @merchants = hash[:merchants]
  end
end
