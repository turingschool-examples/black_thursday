require './lib/merchant_repository'


class Merchant
  attr_reader :id,
              :name

  def initialize(merchant_data)
  #  {  id:  id,
  #   name: name
  # }
  @id = merchant_data[:id]
  @name = merchant_data[:name]
  end
end
