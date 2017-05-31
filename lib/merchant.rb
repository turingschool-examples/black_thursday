require './lib/merchant_repository'


class Merchant
  attr_reader :id,
              :name

  def initialize(merchant_data)
   {  id:  id,
    name: name
  }
  end


end
