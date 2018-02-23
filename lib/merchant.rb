require 'pry'
require_relative '../lib/merchant_repository'
# merchant class
class Merchant
  attr_reader :id,
              :name,
              :parent
  def initialize(data, parent)
    @id   = data[:id].to_i
    @name = data[:name]
    @parent = parent
  end

  def items
    @parent.pass_id_to_se(@id)
  end

  def invoices
    @parent.pass_id_to_se_for_invoice(@id)
  end

  def customers
    ids = invoices.map(&:customer_id)
    @parent.pass_customer_id_to_se(ids)
  end
end
