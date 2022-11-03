# frozen_string_literal: true

# This is the Merchant Class
class Merchant
  attr_reader :id,
              :name

  def initialize(data)
    @id   = data[:id]
    @name = data[:name]
  end

  def update(name)
    @name = name
  end
end
