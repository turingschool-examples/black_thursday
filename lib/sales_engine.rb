require 'csv'

class SalesEngine

  def initialize(info)
    @items = info[:items]
    @merchants = info[:merchants]
  end

  def self.from_csv(info)
    SalesEngine.new(info)
  end

end #SalesEngine class end
