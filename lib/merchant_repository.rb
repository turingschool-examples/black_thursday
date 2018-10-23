require './lib/Repository'
require './lib/Merchant'
class MerchantRepository < Repository

  def initialize()
    @count = 1
  end

  def create(args)
    super(@count, Merchant.new(args))
    @count += 1
  end

end
