class Customer
  attr_reader :id,
              :first_name,
              :last_name,
              :created_at,
              :updated_at,
              :parent_repo

  def initialize(datum, parent_repo = nil)
    @id = datum[:id].to_i
    @first_name = datum[:first_name]
    @last_name = datum[:last_name]
    @created_at = Time.parse(datum[:created_at])
    @updated_at = Time.parse(datum[:updated_at])
    @parent_repo = parent_repo
  end

  def merchants
    parent_repo.find_merchants(id) do |invoices|
      return invoices.map do |invoice|
        invoice.merchant
      end.compact.uniq
    end
  end

end
