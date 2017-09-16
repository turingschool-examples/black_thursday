require_relative "merchant_repository"

class Merchant

  attr_reader :id, :name, :merchant_repository

  def initialize(mr, csv_info)
    @id = csv_info[:id].to_s.to_i
    @name = csv_info[:name]
    @merchant_repository = mr
  end

  def items
    merchant_repository.sales_engine.items.find_all_by_merchant_id(id)
  end

  def invoices
    merchant_repository.sales_engine.invoices.find_all_by_merchant_id(id)
  end

end
