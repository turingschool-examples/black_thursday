# this is merchant class
class Merchant
  attr_reader :id,
              :created_at,
              :merchant_repo
  attr_accessor :name,
                :updated_at
  def initialize(data, merchant_repo)
    @id = data[:id].to_i
    @name = data[:name]
    @updated_at = data[:updated_at]
    @created_at = data[:created_at]
    @merchant_repo = merchant_repo
  end

  def items
    merchant_repo.sales_engine.items.find_all_by_merchant_id(id)
  end

end
