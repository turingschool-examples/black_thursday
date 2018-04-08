# frozen_string_literal: true

# This class holds the infromation about the merchants grabbed from the CSV
# file.
class Merchant
  attr_accessor :merchant_specs
  attr_reader   :parent
  def initialize(merchants, parent)
    @merchant_specs = {
      id:               merchants[:id].to_i,
      name:             merchants[:name],
      searchable_name:  merchants[:name].downcase,
      created_at:       merchants[:created_at],
      updated_at:       merchants[:updated_at]
    }
    @parent = parent
  end

  def id
    @merchant_specs[:id]
  end

  def name
    @merchant_specs[:name]
  end

  def items
    @parent.find_items_by_merchant_id(id)
  end
end
