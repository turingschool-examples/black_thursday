
class Merchant

  attr_reader :name,
              :created_at,
              :id,
              :updated_at,
              :parent


  def initialize(data, parent)
      @name = data[:name]
      @id = data[:id].to_i
      @created_at = date_convert(data[:created_at])
      @updated_at = date_convert(data[:updated_at])
      @parent = parent
  end

  def date_convert(from_file)
    date = from_file.split("-")
    time = Time.new(date[0], date[1], date[2])
  end

  def items
    @parent.parent.items.find_all_by_merchant_id(id)
  end

  def invoices
    @parent.parent.invoices.find_all_by_merchant_id(id)
  end

  def customers
    a = @parent.parent.invoices.find_all_by_merchant_id(id)
    b = a.map do |x|
      x.customer_id
    end.uniq
    c = b.map do |x|
      @parent.parent.customers.contents[x]
    end
  end

end
