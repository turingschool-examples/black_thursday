require './lib/Repository'
require './lib/Merchant'
class MerchantRepository < Repository

  def initialize()
    @count = 1
    super
  end

  def create(name)
    args = {name: name, id: @count}
    super(Merchant.new(args))
    @count += 1
  end
end
