require 'pry'


class Item
  attr_reader :name, :id, :description, :unit_price, :created_at, :updated_at

  #BigDecimal significant figures should == row[:unit_price].size
  #that way it will know what to expect for the length of figures

  #format the time to ( , %F & %T ) that way stuff can be done!
  #be cautious about the UTC time stuff
  #require 'time'
  #"2009-12-09 12:08:04 UTC", "%F, %T"
  #example of how time should be passed in similar to our item csv data file

  def initialize(item_info)
    @name = item_info[:name]
    @id = item_info[:id]
    @description = item_info[:description]
    @unit_price = item_info[:unit_price]
    @created_at = item_info[:created_at]
    @updated_at = item_info[:updated_at]
  end

  # def exact_price(not_exact_price)
  #   price_with_decimal = not_exact_price.insert(-3, ".")
  #   significant_digits = not_exact_price.length
  #   BigDecimal.new(price_with_decimal, significant_digits)
  # end
end
