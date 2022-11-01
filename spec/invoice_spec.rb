require './lib/invoice'

RSpec.describe Invoice do
  it 'exists' do
    invoice = Invoice.new

    expect(invoice).to be_a(Invoice)
  end
end