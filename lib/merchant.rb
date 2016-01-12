class Merchant
  attr_reader :merchant

  def initialize (merchant)
    @merchant = merchant
  end

  def name
    merchant[:name]
  end

  def id
    merchant[:id]
  end

  def created_at
    merchant[:created_at]
  end

  def updated_at
    merchant[:updated_at]
  end
end
