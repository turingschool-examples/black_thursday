# frozen_string_literal: true

# Merchant class has id and name attributes
class Merchant
  attr_reader :id,
              :name,
              :merchant_repository

  def initialize(data, merchant_repository)
    @id = data[:id].to_i
    @name = data[:name]
    @merchant_repository = merchant_repository
  end

  def items
    @merchant_repository.items @id
  end
end
