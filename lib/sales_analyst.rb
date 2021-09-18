class SalesAnalyst

  attr_reader :items,
              :merchants,
              :merch_item_hash

  def initialize(items, merchants)
    @items = items.all
    @merchants = merchants.all
    @merch_item_hash = hash_create #(@items, @merchants)
  end

  def hash_create #(items, merchants)
    return_hash = {}
    @merchants.each do |merchant|
      @items.each do |item|
        if merchant.id == item.merchant_id
          if return_hash[merchant.name].nil?
            return_hash[merchant.name] = [item]
          else
            return_hash[merchant.name] += [item]
          end
        end
      end
    end
    return_hash
  end

end
