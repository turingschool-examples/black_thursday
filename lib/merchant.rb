
require 'pry'

class Merchant
  attr_reader   :name, :id
  attr_accessor :items, :invoices

  def initialize(merchant_info)
    @name       = merchant_info[:name]
    @id         = merchant_info[:id].to_i
  end

end
