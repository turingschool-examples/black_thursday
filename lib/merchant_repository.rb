class MerchantRepository

  attr_reader :merchants, :parent

  def initialize(parent)
    @merchants = []
    @parent = parent
  end

  def create_merchant(data)
    merchants << Merchant.new(data, self)
  end

  def find_by_id(id)
    merchants.find do |merchant|
      merchant.id == id
    end
  end
end
