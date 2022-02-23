require 'csv'

class SalesEngine

  def initialize
    @items = ''
    @merchants = ''
  end

  def self.from_csv(files)
    @items = files[:items]
    @merchants = files[:merchants]
  end

end #SalesEngine class end
