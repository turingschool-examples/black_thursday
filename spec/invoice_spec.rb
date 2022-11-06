require 'simplecov'
SimpleCov.start
require 'rspec'
require 'pry'
require './lib/invoice'

RSpec.describe Invoice do

  it 'invoice exists and has attributes' do
   invoice = Invoice.new ({
                           id: 1,
                           customer_id: 1,
                           merchant_id: 12335938,
                           status: "pending",
                           created_at: Time.now,
                           updated_at: Time.now
                          })

   expect(invoice).to be_instance_of(Invoice)
   expect(invoice.id).to eq(1)
   expect(invoice.customer_id).to eq(1)
   expect(invoice.merchant_id).to eq(12335938)
   expect(invoice.status).to eq(:pending)
   expect(invoice.created_at).to be_instance_of(Time)
   expect(invoice.updated_at).to be_instance_of(Time)
  end

end
