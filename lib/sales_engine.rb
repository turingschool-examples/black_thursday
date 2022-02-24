require 'csv'

class SalesEngine

  def initialize(info)
    @items = info[:items]
    @merchants = info[:merchants]
  end

  def self.from_csv(info)
    SalesEngine.new(info)
  end

  def items
    ItemsRepository.new(@items)
  end

  def merchants
    Merchants.new(@merchants)
  end

end #SalesEngine class end
