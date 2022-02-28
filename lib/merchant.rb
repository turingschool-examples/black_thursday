class Merchant
  attr_accessor :name
  attr_reader :id

  def initialize(info_hash)
    @id = info_hash[:id]
    @name = info_hash[:name]
  end
end
