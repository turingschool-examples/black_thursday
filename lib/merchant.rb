class Merchant
  attr_reader :id
  attr_accessor :name
  @@highest_merchant_id = nil

  def initialize(hash)
    @id = hash[:id]
    @name = hash[:name]
    if @id > @@highest_merchant_id
      @@highest_merchant_id = @id
    end
  end

  def self.create(name)
    merchant_id = @@highest_merchant_id += 1
    Merchant.new({id: merchant_id, name: name})
  end

end
