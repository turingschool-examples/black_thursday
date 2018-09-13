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

  def average_items_per_merchant_standard_deviation
    Math.sqrt(find_standard_deviation_step_three).round(2)
  end

  def merchant_and_item_count_hash
    hash = Hash.new
    find_item_object_per_merchant.each do |id, item_array|
      hash[id] = item_array.length
    end
    hash
  end

  def find_merchant_ids_with_high_item_count
    hash = merchant_and_item_count_hash
    array = []
    hash.each do |id, item_count|
      if item_count > (average_items_per_merchant + average_items_per_merchant_standard_deviation)
        array << id
      else nil
      end
    end
    array
  end

  def merchants_with_high_item_count
    array = []
    find_merchant_ids_with_high_item_count.each do |id|
      merchants.all.each do |merchant|
        if merchant.id == id.to_i
          array << merchant
        end
      end
    end
    array
  end

  def average_item_price_for_merchant(id)
    id = id.to_s
    merchant_items = items.find_all_by_merchant_id(id)
    item_array = merchant_items.map do |item|
      item.unit_price
    end
    sum = item_array.reduce(0) do |sum, price|
      sum += price
      sum
    end
    avg = (sum / item_array.length)
    BigDecimal((sum / item_array.length)).round(2)
  end

  def average_average_price_per_merchant
    average_price_array = find_all_merchant_ids.map do |id|
      average_item_price_for_merchant(id)
    end
    sum = average_price_array.reduce(0) do |sum, price|
      sum += price
      sum
    end
    BigDecimal((sum / average_price_array.length)).round(2)
  end
### Golden Method
  def find_average_item_price_array
    average_price_array = find_all_merchant_ids.map do |id|
      average_item_price_for_merchant(id)
    end
  end

  def find_item_price_standard_deviation_step_one
    find_average_item_price_array.map do |num|
      (num - average_average_price_per_merchant)**2
    end
  end

  def find_item_price_standard_deviation_step_two
    find_item_price_standard_deviation_step_one.reduce(0) do |num, deviation|
      num += deviation
    end
  end

  def find_item_price_standard_deviation_step_three
    find_item_price_standard_deviation_step_two / (find_item_price_standard_deviation_step_one.length - 1)
  end

  def average_item_price_standard_deviation
    Math.sqrt(find_item_price_standard_deviation_step_three).round(2)
  end

end
