require 'csv'
require_relative 'merchant'
require 'date'

class MerchantRepository
  def initialize(csv)
    @all_merchants = Merchant.read_file(csv)
  end

  def all
    @all_merchants
  end

  def find_by_id(id)
    @all_merchants.find{|merchant| merchant.id == id}
  end

  def find_by_name(name)
    @all_merchants.find{|merchant| merchant.name == name}
  end

  def find_all_by_name(name)
    found = []
    found << @all_merchants.find_all{|merchant| merchant.name.downcase == name.downcase}
    found.flatten
  end

  def create(name)
    new_merchant = Merchant.new({
      id: (@all_merchants[-1].id.to_i + 1).to_s,
      name: name,
      created_at: Date.today,
      updated_at: Date.today})
      @all_merchants << new_merchant
  end

  def delete(id)
    @all_merchants.delete(find_by_id(id))
  end

end
