require_relative 'invoice_repository'
require 'time'


class Invoice

  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at

  def initialize(invoice_repository, csv_info)
    @id = csv_info[:id]
    @customer_id = csv_info[:customer_id]
    @merchant_id = csv_info[:merchant_id]
    @status = csv_info[:status]
    @created_at = Time.parse(csv_info[:created_at])
    @updated_at = Time.parse(csv_info[:updated_at])
  end

=begin
  Then connect our invoices to our merchants:

se = SalesEngine.from_csv({
  :items => "./data/items.csv",
  :merchants => "./data/merchants.csv",
  :invoices => "./data/invoices.csv"
})
merchant = se.merchants.find_by_id(12334159)
merchant.invoices
# => [<invoice>, <invoice>, <invoice>]
invoice = se.invoices.find_by_id(20)
invoice.merchant
# => <merchant>
=end

end
