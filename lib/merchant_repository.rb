class MerchantRepository
  attr_reader :merchants

  def initialize(data: [])
    @merchants = data

  end
end
