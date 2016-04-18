class SalesEngine
  attr_reader :items, :merchants

  def self.from_csv(items_merchants_hash)
    @items = items_merchants_hash[:items]
    @merchants = items_merchants_hash[:merchants]
  end

end
