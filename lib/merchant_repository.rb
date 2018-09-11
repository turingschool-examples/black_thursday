require_relative "merchant"

class MerchantRepository

  attr_reader :merchants

  def initialize
    @merchants = []
  end
  def add_merchant(merchant)
    @merchants << merchant
  end

  def all
    merchants
  end

  def find_by_id(id)
    merchants.find {|merchant| merchant.id == id}
  end

  def find_by_name(name)
    merchants.find {|merchant| merchant.name.downcase == name.downcase}
  end

  def find_all_by_name(name)
    @merchants.find_all {|merchant| merchant.name.downcase == name.downcase}
  end

  def create(attributes)
    max_id = (merchants.max_by{|merchant| merchant.id}.id) + 1
    m = Merchant.new({:id => max_id, :name => attributes[:name]})
    add_merchant(m)
    m
  end

  def update(id, attributes)
    if find_by_id(id) == nil

    else
      m = find_by_id(id)
      m.name = attributes[:name]
    end
  end

  def delete(id)
    if find_by_id(id) == nil

    else
      index = merchants.find_index {|i| i.id == id}
      merchants.delete_at(index)
    end
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end
