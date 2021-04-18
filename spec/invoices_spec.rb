require 'rspec'
require 'bigdecimal'
require 'time'
require './lib/invoices'

RSpec.describe Invoice do

  se = SalesEngine.from_csv({
  :invoices => "./data/invoices.csv"
  })
  invoice = se.invoices

  context 'it exists' do
    it 'exists' do
      expect(invoice).to be_instance_of(Invoice)
    end
  end
end
