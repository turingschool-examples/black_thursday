require './lib/Repository'
class MerchantRepository < Repository

  def create(args)
    super(Merchant.new(args))
  end

end
