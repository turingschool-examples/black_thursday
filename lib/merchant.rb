class Merchant

  attr_reader :id,
              :name,
              :merchant_repo

  def initialize(description)
    @id            = description[:id]
    @name          = description[:name]
    @merchant_repo = description[:merchant_repo]
  end

  def self.creator(row, parent)
    new({
      id: row[:id].to_i,
      name: row[:name],
      merchant_repo: parent
    })
  end

  def items # NEEDS TEST
    merchant_repo.find_item(id)
  end

  def invoices # NEEDS TEST
    merchant_repo.find_invoice(id)
  end

  def customers # NEEDS TESTS
    invoices.map(&:customer).uniq
  end

  def revenue # NEEDS TEST
    invoices.reduce(0) do |result, invoice|
      result += invoice.total if invoice.is_paid_in_full?
      result += 0
    end
  end

end
