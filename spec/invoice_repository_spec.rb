# Invoice Test spec
require_relative '../lib/invoice'
require 'pry'

RSpec.describe 'Iteration 2' do
  context 'Invoices' do
    before(:each) do
      @se = SalesEngine.from_csv({
                                   items: './data/items.csv',
                                   merchants: './data/merchants.csv',
                                   invoices: './data/invoices.csv'
                                 })
      @sa = @se.analyst
    end

    it '#all returns all invoices' do
      expected = @se.invoices.all

      expect(expected.length).to eq 4985
    end
  end
end
