require './lib/merchant'

class MerchantRepository

  def initialize(csv_array)
    @csv_array = csv_array
  end

  def all
    @csv_array
  end

  def find_by_id(id)
    @csv_array.find do |merchant|
      merchant.id == id
    end
  end
end
