class Merchant
  # This is the Merchant Class
  # frozen_string_literal: true.
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
