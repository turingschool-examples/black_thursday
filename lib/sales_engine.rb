class SalesEngine

  attr_reader :items,
              :merchants

  def self.from_csv(sales_info)
    @items     = sales_info[:items]
    @merchants = sales_info[:merchants]
  end

  def self.merchants
    @merchants
  end

  def self.items
    @items
  end

end