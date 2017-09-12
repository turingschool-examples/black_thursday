require './lib/merchant'
class MerchantRepository


  def initialize(fields)
    @fields = fields
  end

  def all
    @fields
  end

end
