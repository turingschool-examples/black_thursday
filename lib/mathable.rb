require 'csv'
require 'pry'
require './merchants_repository'
require './items_repository'
class Mathable

  def initialize
    @mr = MerchantsRepository.new("./data/merchants.csv")
    @ir = ItemsRepository.new("./data/items.csv")
  end

  def method

    merchant_ids = @mr.repository.map do |merchant|
      merchant.id
    end.uniq

    array_of_merchant_items = merchant_ids.map do |id|
                        @ir.find_all_by_merchant_id(id)
    end

    items_per_merchant_count = array_of_merchant_items.map do |array|
                            array.count
                            end
                            binding.pry
  end

  def average(repo1, repo2)
    (repo1.count.to_f / repo2.count).round(2)
  end

  def standard_devation(number_list)
    total = number_list.sum
    mean = (total.to_f / number_list.count).round(2)
    sum_squares = number_list.map { |number| square = (number - mean) ** 2}.sum
    variance = sum_squares / (number_list.count - 1)
    st_dev = Math.sqrt(variance).round(2)
    return st_dev
  end
end



#look at each merchants.id
#match merchants.id with each items.merchant_id
#count how many items match
#add the count to an array
