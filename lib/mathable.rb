require 'csv'
require 'pry'
require './merchants_repository'
require './items_repository'
class Mathable

  mr = MerchantsRepository.new("./data/merchants.csv")
  ir = ItemsRepository.new("./data/items.csv")

  mr.repository.each do |merchant|
    ir.repository.find_all do |item|
      item.merchant_id == merchant.id

  def average(repo1, repo2)
    (repo1.count.to_f / repo2.count).round(2)
  end

  def standard_devation(number_list)
    total = number_list.sum
    mean = (total.to_f / number_list.count).round(2)
    # square_diffs = []
    sum_squares = number_list.map { |number| square = (number - mean) ** 2}.sum
    # sum_squares = square_diffs.sum
    variance = sum_squares / (number_list.count - 1)
    st_dev = Math.sqrt(variance).round(2)
    return st_dev
  end
end

#look at each merchants.id
#match merchants.id with each items.merchant_id
#count how many items match
#add the count to an array
