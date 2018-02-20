# frozen_string_literal: true

# Merchant class has id and name attributes
class Merchant
  attr_reader :id, :name

  def initialize(data)
    @id = data[:id]
    @name = data[:name]
  end
end
