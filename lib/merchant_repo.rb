require "pry"

class MerchantRepository
  def initialize(merchants_array)
    @merchants_array = merchants_array
  end

  def all
    @merchants_array
  end

  def find_by_id(id)
    binding.pry
    @merchants_array.find { |merchant| id == merchant.id }
  end
end

# see black thursday site for method descriptions
