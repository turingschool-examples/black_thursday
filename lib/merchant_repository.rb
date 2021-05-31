class MerchantRepository
  attr_reader :all

  def initialize
    @all = []
  end

  def find_by_id(id)
    all.find do |merchant|
      merchant.id == id
    end
  end
end
