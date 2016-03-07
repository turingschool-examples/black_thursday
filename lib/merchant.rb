require 'pry'

class Merchant

  def initialize(sales_engine, row_from_csv)
    @sales_engine = sales_engine
    @id = row_from_csv[:id]
    @name = row_from_csv[:name]
    @created_at = row_from_csv[:created_at]
    @updated_at = row_from_csv[:updated_at]
  end

  def id
    @id.to_i
  end

  def name
    @name
  end

  def created_at
    Time.parse(@created_at)
  end

  def updated_at
    Time.parse(@updated_at)
  end

  def items
    @sales_engine.items.find_all_by_merchant_id(id)
  end

  def customers
    @sales_engine.invoices.find_all_by_merchant_id(id).map do |invoice|
      invoice.customer
    end.uniq  
  end

  def invoices
    @sales_engine.invoices.find_all_by_merchant_id(id)
  end


  def inspect
    "id: #{@id},
name: #{@name},
created_at: #{@created_at},
updated_at: #{@updated_at}"
  end
end
