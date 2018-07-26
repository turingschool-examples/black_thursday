class Merchant

  attr_accessor :id, :name

  def initialize(hash)
    @id = hash[:id].to_i
    @name = hash[:name].to_s
  end

end
