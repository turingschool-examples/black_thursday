require 'csv'

class Merchant
  attr_accessor :merchant_data
  attr_reader :merchant_repo

  def initialize(merchant_data, merchant_repo)
    @merchant_data = merchant_data
    @merchant_repo = merchant_repo
  end

  def id
    merchant_data[0].to_i
  end

  def name
    merchant_data[1]
  end

  def created_at
    merchant_data[2]
  end

  def updated_at
    merchant_data[3]
  end

  def items(id)
    engine = merchant_repo.sales_engine
    engine.items.find_all_by_merchant_id(id)
  end

end
