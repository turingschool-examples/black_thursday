# frozen_string_literal: true

# This class holds the infromation about the merchants grabbed from the CSV
# file.
class Merchant
  attr_accessor :merchant_specs
  def initialize(merchants)
    @merchant_specs = {
      id:               merchants[:id].to_i,
      name:             merchants[:name],
      searchable_name:  name.downcase,
      created_at:       merchants[:created_at],
      updated_at:       merchants[:updated_at]
    }
  end

  def id
    @merchant_specs[:id]
  end

  def name
    @merchant_specs[:name]
  end
end
