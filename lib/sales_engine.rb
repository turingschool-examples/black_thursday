class SalesEngine
  attr_reader :items, :merchants

  def initialize
    @items = ItemRepository.new([])
    @merchants = MerchantRepository.new([])
  end

  def self.from_csv(info)
    self.new
  end




end
