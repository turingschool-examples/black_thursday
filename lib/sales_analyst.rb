class SalesAnalyst < SalesEngine

  def initialize(item_file, merchant_file)
    super(item_file, merchant_file)
  end

  def average_items_per_merchant
    (items.all.count / merchants.all.count.to_f).round(2)
  end


  def find_all_merchant_ids
    merchants.all.map do |merchant|
      merchant.id
    end
  end

end
