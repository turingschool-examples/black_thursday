class SalesAnalyst < SalesEngine

  def initialize(item_file, merchant_file)
    super(item_file, merchant_file)
  end

  def average_items_per_merchant
    (items.all.count / merchants.all.count.to_f).round(2)
  end

  def find_item_object_per_merchant
    items.all.group_by do |item|
      item.merchant_id
    end
  end

  def find_all_merchant_ids
    merchants.all.map do |merchant|
      merchant.id.to_s
    end
  end

  def find_number_of_items_per_merchant
    array = find_item_object_per_merchant.map do |merchant,items|
      items = items.count
    end
  end

  def find_standard_deviation_step_one
    find_number_of_items_per_merchant.map do |num|
      (num - average_items_per_merchant)**2
    end
  end

  def find_standard_deviation_step_two
    find_standard_deviation_step_one.reduce(0) do |num, deviation|
      num += deviation
    end
  end

  def find_standard_deviation_step_three
    find_standard_deviation_step_two / (find_standard_deviation_step_one.length - 1)
  end

  def find_standard_deviation
    Math.sqrt(find_standard_deviation_step_three).round(2)
  end



end
