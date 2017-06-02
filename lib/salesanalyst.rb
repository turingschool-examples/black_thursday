require 'pry'

class SalesAnalyst

  def initialize(parent)
    @parent = parent
  end

  def average_items_per_merchant
    counts = Hash.new(0)
    @parent.items.organize
    x = @parent.items.content.map do |item|
      item["merchant_id"]
    end
    x.each do |id|
      counts[id] += 1
    end
    value = counts.values
    sum = value.reduce(:+)
    leng = value.length
    average = sum.to_f / leng.to_f
  end

  def average_items_per_merchant_standard_deviation
    # Take the difference between each number and the mean and square it
    # Sum these square differences together
    # Divide the sum by the number of elements minus 1
    # Take the square root of this result
    #std_dev = sqrt( ( (3-4)^2+(4-4)^2+(5-4)^2 ) / 2 )
    sum = 0
    counts = Hash.new(0)
    @parent.items.organize
    x = @parent.items.content.map do |item|
      item["merchant_id"]
    end
    x.each do |id|
      counts[id] += 1
    end
    value = counts.values
    value.each_with_index do |element, index|
      h = (element - value[index+1]) **2
      sum += h
    end
    sum /= 2
    Math.sqrt(sum)
  end

  # def list_all_quantities_of_items_per_merchant
  #   counts = Hash.new(0)
  #   @parent.items.organize
  #   x = @parent.items.content.map do |item|
  #     item["merchant_id"]
  #   end
  #   x.each do |id|
  #     counts[id] += 1
  #   end
  #   value = counts.values
  # end
end
