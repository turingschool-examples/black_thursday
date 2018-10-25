class SalesAnalyst
  def initialize # maybe inheritance instead? let's change it.............
    @sales_engine = SalesEngine.from_csv({
    :items     => "./data/item_test.csv",
    :merchants => "./data/merchant_test.csv",
    })
  end

  def average_items_per_merchant
    merchants = @sales_engine.merchants
    items = @sales_engine.items

    avg_items = merchants.all.map do |merchant|
      items.find_all_by_merchant_id(merchant.id).size
    end

    length = avg_items.length
    avg_items = avg_items.inject(0) do |this, item|
      this + item
    end
    avg_items.to_f / length
  end



end
