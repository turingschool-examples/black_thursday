require 'bigdecimal'

require_relative 'repository/record'


class Item < Repository::Record

  attr_reader :name, :description, :unit_price, :merchant_id
  def initialize(repo, fields)
    super(repo, fields)
    @merchant_id =  fields[:merchant_id].to_i
    @name =         fields[:name]
    @description =  fields[:description]
    @unit_price =   (BigDecimal.new fields[:unit_price]) / 100
  end

  def merchant
    repo.parent(:merchants, merchant_id)
  end

end
