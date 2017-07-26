
class Merchant

  attr_reader :id,
              :name

  def initialize(merch_data, merch_repo)
    @id = merch_data[:id].to_i
    @name = merch_data[:name]
    @merch_repo = merch_repo
  end

  def items
    @merch_repo.sales_engine.items.find_all_by_merchant_id(@id)
  end

  def invoices
    @merch_repo.sales_engine.invoices.find_all_by_merchant_id(@id)
  end

end
