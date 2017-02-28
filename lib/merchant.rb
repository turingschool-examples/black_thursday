class Merchant
  attr_reader :merchant_hash, :repository

  def initialize(hash, repository)
    @merchant_hash = hash
    @repository = repository
  end

  def id
    merchant_hash[:id]
  end

  def name
    merchant_hash[:name]
  end

  def created_at
    merchant_hash[:created_at]
  end

  def updated_at
    merchant_hash[:updated_at]
  end

  def items
    repository.engine.items.find_all_by_merchant_id(id)
  end

  def invoices
    repository.engine.invoices.find_all_by_merchant_id(id)
  end

  def customers
    invoices.map! do |invoice|
      invoice.customer
    end.uniq
  end

  def month_created
    month = created_at.month
    case month
    when 1 then 'January'
    when 2 then 'February'
    when 3 then 'March'
    when 4 then 'April'
    when 5 then 'May'
    when 6 then 'June'
    when 7 then 'July'
    when 8 then 'August'
    when 9 then 'September'
    when 10 then 'October'
    when 11 then 'November'
    when 12 then 'December'
    end
  end
end

# m = Merchant.new({:id => 5, :name => "Turing School"})
