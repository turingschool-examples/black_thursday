require_relative 'merchant'
require 'date'

class MerchantRepository
  attr_reader :merchant_repo,
              :parent

  def initialize(loaded_file, parent)
    @merchant_repo = loaded_file.map { |merchant| Merchant.new(merchant, self)}
    @parent = parent
  end

  def all
    @merchant_repo
  end

  def find_by_id(id)
    all.find {|merchant| merchant.id == id}
  end

  def find_by_name(name)
    all.find {|merchant| merchant.name.downcase == name.downcase}
  end

  def find_all_by_name(fragment)
    all.find_all {|merchant| merchant.name.downcase.include?(fragment.downcase)}
  end

  def create(attributes)
    name = attributes[:name]
    highest = all.max_by {|merchant| merchant.id.to_i}
    merchant = {name: name,
                id: (highest.id + 1),
                created_at: Date.today,
                updated_at: Date.today}
    @merchant_repo.push(Merchant.new(merchant, self))
  end

  def update(id_num, attributes)
    merchant = find_by_id(id_num)
    return merchant if merchant == nil
    merchant.update_name(attributes[:name]) if attributes[:name] != nil
  end

  def delete(id)
    merchant = find_by_id(id)
    @merchant_repo.delete(merchant)
  end

  def inspect
   "#{self.class} #{@merchant_repo.size} rows"
  end
end
