require "CSV"
class MerchantRepository
  attr_reader :merchants,
              :parent

  def initialize(merchants, parent = "")
    @merchants = merchants
    @parent    = parent
  end

  def load_csv(filename)
    CSV.open(filename)
  end
end
