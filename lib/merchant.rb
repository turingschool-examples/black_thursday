# frozen_string_literal: true

# This class holds the infromation about the merchants grabbed from the CSV
# file.
class Merchant
  attr_accessor :merchant_specs
  def initialize(merchants)
    @merchant_specs = {
      id:               merchants[:id].to_i,
      name:             merchants[:name],
      searchable_name:  merchants[:name].downcase,
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
#
# x = Merchant.new({:id=>263550472,
#     :name=>"The others could only Watch",
#
#     :merchant_id=>"12334296",
#     :created_at=>"2016-01-11 19:14:50 UTC",
#     :updated_at=>"2011-06-09 19:31:11 UTC"})
