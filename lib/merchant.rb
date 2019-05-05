# frozen_string_literal: true

require 'date'
# This class holds the infromation about the merchants grabbed from the CSV
# file.
class Merchant
  attr_accessor :merchant_specs
  attr_reader   :parent
  def initialize(merchants, parent)
    @merchant_specs = {
      id:               merchants[:id].to_i,
      name:             merchants[:name],
      created_at:       merchants[:created_at],
      updated_at:       merchants[:updated_at]
    }
    @parent = parent
  end

  def searchable_name
    @merchant_specs[:name].downcase
  end

  def id
    @merchant_specs[:id]
  end

  def name
    @merchant_specs[:name]
  end

  def created_at
    @merchant_specs[:created_at]
  end

  def updated_at
    @merchant_specs[:updated_at]
  end

  def items
    @parent.find_items_by_merchant_id(id)
  end

  def invoices
    @parent.find_invoices_by_merchant_id(id)
  end

  def customers
    @parent.find_customers_by_merchant_id(id)
  end
end
