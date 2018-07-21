class Merchant
  attr_reader :id
  attr_accessor :name
  @@highest_merchant_id = 0

  def initialize(hash)
    @id = hash[:id].to_i
    @name = hash[:name]
    if @id > @@highest_merchant_id
      @@highest_merchant_id = @id
    end
  end

  def self.create(name)
    merchant_id = @@highest_merchant_id += 1
    require 'pry' ; binding.pry
    Merchant.new({id: merchant_id, name: name})
  end

end
