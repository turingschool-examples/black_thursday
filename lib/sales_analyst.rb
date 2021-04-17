class SalesAnalyst

  attr_reader :engine

  def initialize(engine)
    @engine = engine
  end

  def find_all_merchants
    @engine.merchants.array_of_objects
  end

  def find_all_items
    @engine.items.array_of_objects
  end

  def get_merchant_ids(merchants)
    merchants.map do |merchant|
      merchant.id
    end
  end

  def average_items_per_merchant(merchants)
    merchant_ids = get_merchant_ids(merchants)
    item_counter = 0
    merchant_ids.each do |merchant_id|
      if find_all_by_merchant_id.include?(merchant_id)
        item_counter += 1
        require 'pry'; binding.pry
      end
    end
    #for each id, compare against merchant ids in items
    #each time id is matched, add += 1 to counter

    # counter / merchants.length.to_f

    #avg.truncate(2)
  end

  def sample_merchants_return_id
    merch_sample = find_all_merchants.sample(10)
    get_merchant_ids(merch_sample)
  end

  def stnd_dev_of_merch_items
    merchant_items = []
    sample_merchants_return_id.each do |merchant_id|
      merchant_items << find_all_by_merchant_id(merchant_id).length
    end

    sample_size_minus_one = merchant_items.length - 1
    counter = 0
    merchant_items.each do |number|
      running_total = (number)**2 # add in average subtracted here
      counter += running_total
    end
    Math.sqrt(counter / sample_size_minus_one)

  end

  def find_all_by_merchant_id(merchant_id)
    find_all_items.find_all do |item|
      item.merchant_id == merchant_id
    end
  end
    # sqrt (((std_dev_arry[0]-average_items_per_merchant)**2)+
    #         (std_dev_arry[1]-average_items_per_merchant)**2)+
    #         (std_dev_arry[2, et cetera]-average_items_per_merchant)**2)
    #       /2)
end
end
