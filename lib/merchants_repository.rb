class MerchantsRepository
  attr_reader :all

  def initialize(merchant_array)
    @all = merchant_array

  end

  def find_by_id(id)
    @all.find
end
