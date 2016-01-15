require 'pry'

class Merchant
  attr_reader   :name, :id
  attr_accessor :items

  def initialize(merchant_info)
    @name       = merchant_info[:name]
    @id         = merchant_info[:id]
  end




end
