require_relative './spec_helper'

RSpec.describe InvoiceRepository do
  describe 'instantiation' do
    it 'exists' do
      RSpec.describe InvoiceItem do
        describe 'instantiation' do
          before :each do
            se = SalesEngine.new({ items: 'spec/fixtures/items.csv', merchants: 'spec/fixtures/merchants.csv', invoices: 'spec/fixtures/invoices.csv', invoice_item: 'spec/fixtures/invoice_items.csv' })
            t = Transaction.new({
                    :id => 6,
                    :invoice_id => 8,
                    :credit_card_number => "4242424242424242",
                    :credit_card_expiration_date => "0220",
                    :result => "success",
                    :created_at => Time.now,
                    :updated_at => Time.now
                    }, @se)
          end

        end
      end
    end
  end
end
