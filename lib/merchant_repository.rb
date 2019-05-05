# frozen_string_literal: true

require_relative 'merchant.rb'
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
    id_array = @merchant_list.map(&:id)
    new_id = id_array.max + 1
    attributes[:id] = new_id.to_s
    @merchant_list << Merchant.new(attributes, self)
  end

  def find_by_id(id)
    @merchant_list.find { |merchant| merchant.merchant_specs[:id] == id }
  end

  def find_by_name(name)
    @merchant_list.find do |merchant|
      merchant.searchable_name == name.downcase
    end
  end

  def all
    @merchant_list
  end

  def find_all_by_name(name)
    @merchant_list.find_all do |merchant|
      merchant.searchable_name.include?(name.downcase)
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @merchant_list.find_all do |merchant|
      merchant.merchant_specs[:id] == merchant_id
    end
  end

  def delete(id)
    merchant_to_delete = find_by_id(id)
    @merchant_list.delete(merchant_to_delete)
  end

  def update(id, attributes)
    merchant = find_by_id(id)
    unchangeable_keys = %i[id created_at]
    attributes.each do |key, value|
      next if (attributes.keys & unchangeable_keys).any?
      if merchant.merchant_specs.keys.include?(key)
        merchant.merchant_specs[key] = value
        merchant.merchant_specs[:updated_at] = Time.now
      end
    end
  end

  def find_items_by_merchant_id(merchant_id)
    @parent.find_all_items_by_merchant_id(merchant_id)
  end

  def find_invoices_by_merchant_id(merchant_id)
    @parent.find_invoices_by_merchant_id(merchant_id)
  end

  def find_customers_by_merchant_id(merchant_id)
    @parent.find_customers_by_merchant_id(merchant_id)
  end

  def inspect
    "<#{self.class} #{@merchant_list.size} rows>"
  end
end
