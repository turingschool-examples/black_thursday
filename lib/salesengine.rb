class SalesEngine
  attr_reader :csv

  def initialize(csv)
    @items = csv[:items]
    @merchants = csv[:merchants]
  end

end
