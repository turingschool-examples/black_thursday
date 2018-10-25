class SalesAnalyst
  def initialize(sales_engine)
    @sales_engine = sales_engine # maybe inheritance instead? let's change it.............
    @item_repo = sales_engine.items
    @merchant_repo = sales_engine.merchants
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


  # def merchants_with_high_item_count
  #
  # end

  def average_item_price_for_merchant(id)
    list = @item_repo.find_all_by_merchant_id(id)
    total = 0
    count = 0
    list.each do |item|
      item.unit_price += total
      count += 1
    end
    total / count
  end



end
