# frozen_string_literal: true

class MerchantRepository
  attr_reader :all

  def initialize
    @all = []
  end

  def add_merchant_to_repo(merchant)
    @all << merchant
  end

  def find_by_id(id_num)
    @all.find do |merchant|
      merchant.id == id_num
    end
  end

  def find_by_name(name)
    @all.find do |merchant|
      merchant.name.downcase == name.downcase
    end
  end

  def find_all_by_name(name)
    @all.find_all do |merchant|
      merchant.name.downcase.include?(name.downcase)
    end
  end

  def create(attributes)
    attributes[:id] = max_id
    add_merchant_to_repo(Merchant.new(attributes))
  end

  def max_id
    max = @all.max_by(&:id)
    return 1 if max.nil?

    (max.id + 1)
  end

  def update(id, attributes)
    return nil if find_by_id(id).nil?

    name = attributes[:name]
    find_by_id(id).name = name
  end

  def delete(id)
    @all.delete(find_by_id(id))
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end
