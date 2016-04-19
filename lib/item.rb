# require 'BigDecimal'

class Item

  attr_reader :id, :name, :description, :unit_price, :created_at, :updated_at, :sales_engine

  def initialize(data, sales_engine)
    @id = data[:id].to_i
    @name = data[:name]
    @description = data[:description]
    @unit_price = data[:unit_price].to_i/100
    #BigDecimal.new(data[:unit_price].to_i/100, 4) #uncertain of 4 as param here
    @created_at = data[:created_at]  #need to reformat time
    @updated_at = data[:updated_at] #need to reformat time
    @sales_engine = sales_engine
  end

end
