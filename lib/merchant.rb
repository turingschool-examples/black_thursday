# frozen_string_literal: true

# merchant
class Merchant
  attr_reader :id,
              :name,
              :created_at,
              :updated_at,
              :merchant_repository

  def initialize(data, parent)
    @id                  = data[:id].to_i
    @name                = data[:name]
    @created_at          = data[:created_at]
    @updated_at          = data[:updated_at]
    @merchant_repository = parent
  end

  def change_name(name)
    @name = name
  end

  def change_updated_at
    @updated_at = Time.now
  end

  def items
    @merchant_repository.pass_merchant_id_to_engine(@id)
  end

  def invoices
    @merchant_repository.pass_merchant_id_to_engine_for_invoice(@id)
  end
end
