require 'csv'

class MerchantRepository
  def initialize(csv)
    @csv = CSV.read(csv)
  end
end
