require_relative 'merchant_repository'
require_relative 'item_repository'


class SalesEngine
  def initialize(data)
    @data = data
  end

  def self.from_csv(data)
    new(data)
  end

end
