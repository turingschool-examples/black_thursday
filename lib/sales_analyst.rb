class SalesAnalyst

  attr_reader :items,
              :merchants

  def initialize(items, merchants)
    @merchants = merchants
    @items = items
  end

  def merch_item_creation(items, merchants)
    return_hash = {}
    merchants.all.each do |merchant|
    items.all.each do |item|
      if merchant.id == item.merchant.id
        if return_hash[merchant].nil?
          return_hash[merchant.name] = [item]
        else
          return_hash[merchant.name] += [item]
        end
      end
    end
  end
end
