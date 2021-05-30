class Merchant
  attr_reader :id,
              :name

  def initialize(merchant_hash)
    @id = merchant_hash[:id]
    @name = merchant_hash[:name]
  end

  def to_hash
    self_hash = Hash.new
    self_hash[:id] = @id
    self_hash[:name] = @name
    self_hash
  end
end
