# frozen_string_literal: true

# :nodoc:
class Merchant
  attr_reader :id, :name
  def initialize(merchant)
    @id   = merchant[:id].to_i
    @name = merchant[:name]
  end
end
