class Merchant
  attr_reader :id, :name

  def initialize(info_hash)
    @id = info_hash[:id]
    @name = info_hash[:name]
  end

end
