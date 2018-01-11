class Merchant

  attr_reader :id,
              :name,
              :merchant_repo,
              :created_at

  def initialize(description)
    @id            = description[:id]
    @name          = description[:name]
    @merchant_repo = description[:merchant_repo]
    @created_at    = Time.parse(description[:created_at])
  end

  def self.creator(row, parent)
    new({
      id: row[:id].to_i,
      name: row[:name],
      created_at: row[:created_at],
      merchant_repo: parent
    })
  end

  def items
    merchant_repo.find_item(id)
  end

  def invoices
    merchant_repo.find_invoice(id)
  end

  def customers
    invoices.map(&:customer).uniq
  end

  def revenue
    invoices.reduce(0) do |result, invoice|
      result += invoice.total if invoice.is_paid_in_full?
      result += 0
    end
  end

end
