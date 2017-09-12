require 'pry'

class Merchant
  attr_accessor :id, :name


  def initialize(merchant = {})
    @id = merchant.fetch(:id)
    @name = merchant.fetch(:name)
  end

end
