class SalesAnalyst < SalesEngine

  def initialize(item_file, merchant_file)
    super(item_file, merchant_file)
  end

  def average_items_per_merchant
    (items.all.count / merchants.all.count.to_f).round(2)
  end

  def average_items_per_merchant_standard_deviation
    h = Hash.new(0)
    find_all_merchant_ids.each do |merchant_id|
      h[:merchant_id]
      ir = items
      ir.all
      ir.items.each do |item|
        if item.merchant_id == merchant_id
          h[:merchant_id] += 1
        end
      end
    end
  end

  def find_all_merchant_ids
    merchants.all.map do |merchant|
      merchant.id.to_s
    end
  end

end
