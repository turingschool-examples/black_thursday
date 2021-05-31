require './lib/merchant'

class MerchantRepository
  attr_reader :all

  def initialize
    @all = []
  end

  def find_by_id(id)
    all.find do |merchant|
      merchant.id == id
    end
  end

  def find_by_name(name)
    all.find do |merchant|
      merchant.name.downcase == name.downcase
    end
  end

  def find_all_by_name(name)
    all.find_all do |merchant|
      merchant.name.downcase.include?(name.downcase)
    end
  end

  def create(attributes)
    max_id = all.max_by do |merchant|
      merchant.id
    end
    new_id = max_id.id + 1
    Merchant.new({:id => new_id, :name => attributes})
  end
end
