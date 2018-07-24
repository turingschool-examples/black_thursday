require_relative 'repository'

class MerchantRepository
  include Repository

  def initialize(merchants)
    @list = merchants
  end

  def find_all_by_name(name)
    @list.find_all do |merchant|
      merchant.name.downcase.include?(name)
    end
  end

  def create(attributes)
    highest_merchant_id = @list.max_by do |merchant|
      merchant.id
    end
    attributes[:id] = highest_merchant_id.id + 1
    @list << Merchant.new(attributes)
  end

  def update(id, attributes)
    if find_by_id(id)
      find_by_id(id).name = attributes[:name]
    end
  end

  def inspect
    "#<#{self.class} #{@list.size} rows>"
  end
end
