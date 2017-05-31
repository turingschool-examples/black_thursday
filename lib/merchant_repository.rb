class MerchantRepository

  attr_reader :all

  def initialize
    @all = []
  end

  def find_by_id(id)
    @all.find do |merchant|
      if merchant.id == id
        return merchant
      end
      nil
    end
  end

end
