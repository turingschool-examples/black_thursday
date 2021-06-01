require './lib/merchant'

class MerchantRepository
  attr_reader :all

  def initialize
    @all = []
  end

  def find_by_id(id)
    all.find { |merchant| merchant.id == id }
  end

  def find_by_name(name)
    all.find { |merchant| merchant.name.downcase == name.downcase }
  end

  def find_all_by_name(name)
    all.find_all { |merchant| merchant.name.downcase.include?(name.downcase) }
  end

  def create(attributes)
    max_id = all.max_by { |merchant| merchant.id }
    new_id = max_id.id + 1
    Merchant.new({:id => new_id, :name => attributes})
  end

  def update(id, attributes)
     find_by_id(id).update(attributes)
  end

  def delete(id)
    all.delete(find_by_id(id))
  end
end
