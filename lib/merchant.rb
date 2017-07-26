require './lib/merchant_repository'

class Merchant

  attr_reader :name,
              :id,
              :created_at,
              :updated_at

  def initialize(merchant_info, merchant_repo)
    @name           = merchant_info[:name]
    @id             = merchant_info[:id].to_i
    @created_at     = merchant_info[:created_at]
    @updated_at     = merchant_info[:updated_at]
    @merchant_repo  = merchant_repo
  end

  def items
    item_repo = @merchant_repo.sales_engine.items
    item_repo.find_all_by_merchant_id(@id)
  end

end
