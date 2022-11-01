class MerchantRepository
  attr_reader :all

  def initialize
    @all = []
  end

  def add_merchant_to_repo(merchant)
    @all << merchant
  end
end
