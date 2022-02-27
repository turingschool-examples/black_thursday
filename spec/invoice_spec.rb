# Invoice Test spec
require_relative '../lib/invoice'
require 'pry'

RSpec.describe 'Iteration 2' do
  context 'Invoices' do
    it '#all returns all invoices' do
      i = Invoice.new({
                        id: 6,
                        customer_id: 7,
                        merchant_id: 8,
                        status: 'pending',
                        created_at: Time.now,
                        updated_at: Time.now
                      })

      expect(i).to be_an(Invoice)
    end
  end
end
