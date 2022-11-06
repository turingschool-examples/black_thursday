require './lib/mathable'
require './lib/sales_analyst'
require './lib/sales_engine'
require './lib/item_repository'
require './lib/invoice_item_repository'
require './lib/customer_repository'

RSpec.describe Mathable do
  let(:sales_engine) {SalesEngine.from_csv({:items => './data/items.csv',
                                            :merchants => './data/merchants.csv',
                                            :invoices => './data/invoices.csv',
                                            :invoice_items => './data/invoice_items.csv',
                                            :customers => './data/customers.csv',
                                            :transactions => './data/transactions.csv'})}
  let(:sales_analyst) {sales_engine.analyst}

  describe '#sum_square_diff' do
    it 'calculates the numerator for the stdev formula' do
      expect(sales_analyst.sum_square_diff([*1..10])).to eq 82.5
    end
  end

  describe '#average' do
    it 'calculates the average of a set' do
      expect(sales_analyst.average([*1..10])).to eq 5.5
    end
  end
end