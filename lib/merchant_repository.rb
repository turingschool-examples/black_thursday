class MerchantRepository
  attr_reader :all

  def initialize
    @all = []
  end

  def add_merchant_to_repo(merchant)
    @all << merchant
  end

  def find_by_id(id_num)
    @all.find do |merchant|
      merchant.id == id_num
    end
  end
end
