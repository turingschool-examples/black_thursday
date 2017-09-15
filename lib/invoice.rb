require_relative 'invoice_repository'
require 'bigdecimal'
require 'time'


class Invoice

  attr_reader :id,
              :custom_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at,


  def initialize(ir, csv_info)
    @id = csv_info[:id].to_i
    @custom_id = csv_info[:custom_id]
    @merchant_id = csv_info[:merchant_id]
    @status = csv_info[:status]
    @created_at = Time.parse(csv_info[:created_at].to_s)
    @updated_at = Time.parse(csv_info[:updated_at].to_s)
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
