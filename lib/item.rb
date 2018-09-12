<<<<<<< HEAD
require 'pry'
require_relative './merchant'
=======
require 'csv'
require 'bigdecimal'
require 'time'
>>>>>>> f383e696193518f2683634daad455d6f6829953c

class Item

  attr_reader :id,
              :created_at,
              :merchant_id
  attr_accessor :name,
                :description,
                :unit_price,
                :updated_at

  def initialize(data)
    @id = data[:id]
    @name = data[:name]
    @description = data[:description]
    @unit_price = data[:unit_price]
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
    @merchant_id = data[:merchant_id]
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end

end
