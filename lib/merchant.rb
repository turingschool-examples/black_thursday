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

  def invoices


  end

  def inspect
#     "id: #{@id},
# name: #{@name},
# created_at: #{@created_at},
# updated_at: #{@updated_at}"
  end
end
