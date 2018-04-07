# frozen_string_literal: true

# This object holds all of the merchants. On initialization, we feed in the
# seperated out list of merchants, which we obtained from the CSV file. For each
# row, denoted here by the merchant variable, we insantiate a new item object
# that includes a reference to it's parent. We store this list in the
# merchant_list isntance variable, allowing us to reference the list outside of
# this class. The list is stored as an array.
class MerchantRepository
  attr_reader :merchant_list,
              :parent
  def initialize(merchants, parent)
    @merchant_list = merchants.map { |merchant| Merchant.new(merchant, self) }
    @parent = parent
  end

  def create(attributes)
    @merchant_list << Merchant.new(attributes)
  end

  def find_by_id(id)
    @merchant_list.find { |merchant| merchant.merchant_specs[:id] == id }
  end

  def find_by_name(name)
    @merchant_list.find { |merchant| merchant.merchant_specs[:name] == name }
  end

  def all
    @merchant_list
  end

  def find_all_by_name(name)
    @merchant_list.find_all do |merchant|
      merchant.merchant_specs[:searchable_name] == name.downcase
    end
  end

  def delete(id)
    merchant_to_delete = find_by_id(id)
    @merchant_list.delete(merchant_to_delete)
  end

  def update(id, attributes)
    merchant = find_by_id(id)
    attributes.each do |key, value|
      if merchant.merchant_specs.keys.include?(key)
        merchant.merchant_specs[key] = value
        merchant.merchant_specs[:updated_at] = Time.now
      end
    end
  end
end
