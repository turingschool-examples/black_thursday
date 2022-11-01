class MerchantRepository
  attr_reader :merchants

  def initialize
    @merchants = []
  end

  def create(data)
    data[:id] ||= 1 if merchants == [] 
    data[:id] ||= (@merchants.last.id.to_i + 1).to_s 
    @merchants << Merchant.new(data)
  end
end
