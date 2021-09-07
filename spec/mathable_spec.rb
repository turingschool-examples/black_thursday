require 'simplecov'
SimpleCov.start
require './lib/mathable'
require './lib/invoice_repository'

RSpec.describe Mathable do
  
  describe '#average' do
    it 'can find an average' do

    mock_sales_engine = instance_double('SalesEngine')
    ir = InvoiceRepository.new('./data/invoices.csv', mock_sales_engine)

    expect(ir.average(ir.invoices_by_days)).to eq(712.1428571428571)
    end
  end

  describe '#hash_variance_from_mean' do
    it 'shows variance from mean' do
      mock_sales_engine = instance_double('SalesEngine')
      ir = InvoiceRepository.new('./data/invoices.csv', mock_sales_engine)

      expect(ir.hash_variance_from_mean(ir.invoices_by_days)).to eq({ 'Friday' => 124.16326530612173,
                                                                      'Monday' => 260.59183673469283,
                                                                      'Saturday' => 284.16326530612355,
                                                                      'Sunday' => 17.16326530612218,
                                                                      'Thursday' => 34.30612244897997,
                                                                      'Tuesday' => 405.7346938775497,
                                                                      'Wednesday' => 832.7346938775529 })
    end
  end

  describe '#standard_deviation' do
    it 'shows standard deviation' do
      mock_sales_engine = instance_double('SalesEngine')
      ir = InvoiceRepository.new('./data/invoices.csv', mock_sales_engine)

      expect(ir.standard_deviation(ir.invoices_by_days)).to eq(18.07)
    end
  end
end
