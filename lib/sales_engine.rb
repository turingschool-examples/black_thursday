require './../black_thursday/lib/merchant_repository'


class SalesEngine

  attr_reader :merchants

  def initialize(paths)
    @merchants = MerchantRepository.new(paths[:merchants])
  end

  def self.from_csv(data_paths)
    self.new(data_paths)
  end

end
