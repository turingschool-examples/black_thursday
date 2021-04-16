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

  def average_items_per_merchant
    avg = find_all_items.length / find_all_merchants.length.to_f
    avg.truncate(2)
  end

  def average_items_per_merchant_standard_deviation
    std_dev_arry = []
    counter = 0
    merch_sample = find_all_merchants.sample(10)
    merchant_ids = merch_sample.map do |merchant|
      merchant.id
    end
    merchant_items = []
    random_items = merchant_ids.each do |merchant_id|
      merchant_items << find_all_by_merchant_id(merchant_id).length
    end
    # range = 1..10
    # sample = range.to_a.sample(5)
    # find_all_merchants each
    # find their items (count)
    # std_dev_arry << items
      merchant_items.each do |number|
        i = (number - average_items_per_merchant)**2
        counter += i
      end
    test = Math.sqrt(counter / 2)
    require 'pry'; binding.pry
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
