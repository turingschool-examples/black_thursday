require './lib/merchant'

class MerchantRepository

  def initialize(csv_array)
    @csv_array = csv_array
  end

  def all
    @csv_array
  end
end
