require 'csv'
require 'pry'
require './merchants_repository'
require './items_repository'
class Mathable

  def initialize
    @mr = MerchantsRepository.new("./data/merchants.csv")
    @ir = ItemsRepository.new("./data/items.csv")
  end

  def average(array)
    sum = array.sum
    count = array.count
    @mean = sum / count
  end

  def standard_devation(number_list, mean)
    total = number_list.sum
    sum_squares = number_list.map { |number| (number - mean) ** 2}.sum
    variance = sum_squares / (number_list.count - 1)
    st_dev = Math.sqrt(variance).round(2)
    return st_dev
  end
  
end
