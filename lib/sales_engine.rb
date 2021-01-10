class SalesEngine
  include Math

  attr_reader :merchants,
              :items

  def initialize(csv_data)
    make_merchant_repo(csv_data)
    make_item_repo(csv_data)
  end

  def find_merchant_by_merchant_id(id)
    merchants.find_by_id(id)
  end

  def find_average
    (items.item_list.count.to_f / merchants.merchant_list.count.to_f).round(2)
  end

def standard_deviation

  total_count = @merchants.merchant_list.reduce([]) do |acc, merchant|
    acc << merchant.item_name.count
    acc
  end

  sum = total_count.sum do |value|
    ((value - find_average)**2)
  end
  result = (sum / 475)

  Math.sqrt(result).round(2)
end


# new_sum = ((sum / 475) - 1)

# summy = (sum / 475) - 1
#
# sum = total_count.reduce(0) do |acc, val|
#   acc += ((val - find_average)**2)



  # std_dev = sqrt( ( (3-4)^2+(4-4)^2+(5-4)^2 ) / 2 )

    # sum = 0

#     total_count.each_value do |value|
#       ((value - find_average) ** 2).sum
#     end


    # @items.item_list.reduce({}) do |acc, item|
    #   merchat_total = @merchants.merchant_list.map do |merchant|
    #     (merchant - find_average)**2
    #   end.sum
    #
    #     (item - find_average)**2
    #





  #   sum => number of items in our item list **2 - number of merchants in our merhcnat list**2
  #
  #
  #   sum = items.item_list.reduce({}) do |acc, i|
  #     acc + (i - mean) ** 2
  #   end
  #   sum / (items.item_list.length - 1).to_f
  # end
  #
  # def standard_deviation
  #   Math.sqrt(find_variance)

  def find_items_by_id(id)
    items.find_all_by_merchant_id(id)
  end

  def analyst
    SalesAnalyst.new(self)
  end

  def self.from_csv(csv_data)
    SalesEngine.new(csv_data)
  end

  def make_merchant_repo(csv_data)
    @merchants = MerchantRepo.new(csv_data[:merchants], self)
  end

  def make_item_repo(csv_data)
    @items = ItemRepo.new(csv_data[:items], self)
  end
end
