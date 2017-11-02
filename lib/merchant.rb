require 'time'

class Merchant
  attr_reader :merchant

  def initialize(merchant)
    @merchant = merchant
  end

  def id
    merchant.fetch(:id).to_i
  end

  def name
    merchant.fetch(:name)
  end

  def created_at
    Time.now
  end

  def updated_at
    Time.now
  end
end
