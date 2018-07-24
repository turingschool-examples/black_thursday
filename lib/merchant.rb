# frozen_string_literals: true

# ./lib/merchant.rb
class Merchant
  attr_reader :id
  attr_accessor :name

  @@highest_merchant_id = 0

  def initialize(hash)
    @id = hash[:id].to_i
    @name = hash[:name]
    highest_id_updater
  end

  def highest_id_updater
    @@highest_merchant_id = @id if @id > @@highest_merchant_id
  end

  def self.create(name)
    merchant_id = @@highest_merchant_id += 1
    Merchant.new(id: merchant_id, name: name[:name])
  end
end
