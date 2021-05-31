require 'csv'

class SalesEngine
  attr_reader :items, :merchants

  def initialize(data_hash)
    @items = data_hash[:items]
    @merchants = data_hash[:merchants]

  end

  def self.from_csv(data_hash)
    SalesEngine.new(data_hash)
  end 



end 