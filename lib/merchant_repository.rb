class MerchantRepository
  #se.merchants -- merchants is salesengine method
  def initialize(hash)
    hash.each do |row|
      @id = row[:id]
      @name = row[:name]
      @created_at = row[:created_at]
      @updated_at = row[:updated_at]
    end
    @merchants = []
  end
  def all
    @merchants
  end
  def find_by_id(id)
    @merchants.find { |hash| hash[:id] == id }
  end
  def find_by_name(name)
    @merchants.find { |hash| hash.value(:name) == name}
  end
  def find_all_by_name(name)
        @merchants.find_all { |hash| hash.value(:name) == name}
  end
end

class Merchant
  attr_reader :id, :name
  def initialize(hash)
    @id = hash[:id]
    @name = hash[:name]
  end
end
