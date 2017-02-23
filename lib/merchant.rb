class Merchant
  attr_reader :id, :name

  def initialize(row)
    @id = row[:id]
    @name = row[:name]
  end
  #
  #
  # def initialize(merchant_info)
  #   @merchant_info = merchant_info
  #
  # end
  #
  #
  # def id
  #   @merchant_info[:id]
  #   # returns the integer id of the merchant
  # end
  #
  # def name
  #   # returns the name of the merchant
  #   @merchant_info[:name]
  # end
  #



end
