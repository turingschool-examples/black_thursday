require './lib/sales_engine'
require 'pry'

class MerchantRepository < SalesEngine
  attr_reader :merchants_array
  def initialize(merchants_array)
    @merchants_array = merchants_array
  end

  def all
    @merchants_array
  end
# find_by_name must return nil name doesn't exist
  def find_by_name(name)
    findings = @merchants_array.find_all do |merchant|
      merchant.name.downcase == name.downcase
    end

    findings = nil if findings == []
    findings
  end

  def find_by_id(id)
    findings = @merchants_array.find_all do |merchant|
      merchant.id == id
    end
    findings = nil if findings == []
    findings
  end

  def find_all_by_name(name)
    chars = name.length
    down_case_name = name.downcase
    @merchants_array.find_all do |merchant|
      prefix = merchant.name[0..chars - 1].downcase
      down_case_name == prefix
    end
  end

  def create(name)
    last_merchant = @merchants_array.last
    if last_merchant == nil
      max_id = 1
    else
      max_id = last_merchant.id + 1
    end
    attributes = {:id => max_id, :name => name}
    @merchants_array << Merchant.new(attributes)
  end

  def update(id, attributes)
    name = attributes[:name]
    merchant = find_by_id(id)
    merchant[0].updated_at = Date.today.to_s
    merchant[0].name = name
  end

  def delete(id)
    merchant = find_by_id(id)
    if merchant != []
      @merchants_array.delete_at(0)
    else
      "Merchant not found"
    end
  end
end
