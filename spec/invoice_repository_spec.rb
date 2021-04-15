require 'simplecov'
SimpleCov.start
require './lib/sales_engine'
require './lib/invoice_repository'
require './lib/invoice'
require 'bigdecimal'

RSpec.describe InvoiceRepository do
  describe '#initialize' do
    it 'exists' do
      mock_sales_engine = instance_double('SalesEngine')
      ir = InvoiceRepository.new('./data/invoices.csv', mock_sales_engine)
      expect(ir).to be_instance_of(InvoiceRepository)
    end
    it 'has items' do
      mock_sales_engine = instance_double('SalesEngine')
      ir = InvoiceRepository.new('./data/invoices.csv', mock_sales_engine)
      expect(ir.invoices.count).to eq(4985)
    end
  end
  describe '#make_invoices' do
    it 'makes_invoices' do
      mock_sales_engine = instance_double('SalesEngine')
      ir = InvoiceRepository.new('./data/invoices.csv', mock_sales_engine)
      expect(ir.invoices.first).to be_instance_of(Invoice)
    end
  end
  describe '#all' do
    it 'contains all the invoices' do
      mock_sales_engine = instance_double('SalesEngine')
      ir = InvoiceRepository.new('./data/invoices.csv', mock_sales_engine)
      expect(ir.all.count).to eq(4985)
    end
  end
  describe '#find_by_id' do
    it 'finds invoices by id' do
      mock_sales_engine = instance_double('SalesEngine')
      ir = InvoiceRepository.new('./data/invoices.csv', mock_sales_engine)
      test_invoice = Invoice.new({
        id: '1234567890',
        customer_id: '456789',
        merchant_id: '234567890',
        status: 'pending',
        created_at: '2016-01-11 11:51:37 UTC',
        updated_at: '1993-09-29 11:56:40 UTC'
    },
    ir
    )
      ir.invoices << test_invoice
      expect(ir.find_by_id(1234567890)).to eq(test_invoice)
      expect(ir.find_by_id(123456789099999999)).to eq(nil)
    end
  end
  describe '#find_all_by_customer_id' do
    it 'finds invoices by customer id' do
      mock_sales_engine = instance_double('SalesEngine')
      ir = InvoiceRepository.new('./data/invoices.csv', mock_sales_engine)
      test_invoice1 = Invoice.new({
        id: '1234567890',
        customer_id: '456789',
        merchant_id: '234567890',
        status: 'pending',
        created_at: '2016-01-11 11:51:37 UTC',
        updated_at: '1993-09-29 11:56:40 UTC'
    },
    ir
    )
    test_invoice2 = Invoice.new({
        id: '1234567890',
        customer_id: '456789',
        merchant_id: '234567890',
        status: 'pending',
        created_at: '2016-01-11 11:51:37 UTC',
        updated_at: '1993-09-29 11:56:40 UTC'
    },
    ir
    )
      ir.invoices << test_invoice1
      ir.invoices << test_invoice2
      expect(ir.find_all_by_customer_id(456789)).to eq([test_invoice1, test_invoice2])
      expect(ir.find_all_by_customer_id(123456789099999999)).to eq([])
    end
  end
  describe '#find_all_by_merchant_id' do
    it 'finds invoices by merchant id' do
      mock_sales_engine = instance_double('SalesEngine')
      ir = InvoiceRepository.new('./data/invoices.csv', mock_sales_engine)
      test_invoice1 = Invoice.new({
        id: '1234567890',
        customer_id: '456789',
        merchant_id: '234567890',
        status: 'pending',
        created_at: '2016-01-11 11:51:37 UTC',
        updated_at: '1993-09-29 11:56:40 UTC'
    },
    ir
    )
    test_invoice2 = Invoice.new({
        id: '1234567890',
        customer_id: '456789',
        merchant_id: '234567890',
        status: 'pending',
        created_at: '2016-01-11 11:51:37 UTC',
        updated_at: '1993-09-29 11:56:40 UTC'
    },
    ir
    )
      ir.invoices << test_invoice1
      ir.invoices << test_invoice2
      expect(ir.find_all_by_merchant_id(234567890)).to eq([test_invoice1, test_invoice2])
      expect(ir.find_all_by_merchant_id(123456789099999999)).to eq([])
    end
  end
  describe '#find_all_by_status' do
    it 'finds invoices by status' do
      mock_sales_engine = instance_double('SalesEngine')
      ir = InvoiceRepository.new('./data/invoices.csv', mock_sales_engine)
      expect(ir.find_all_by_status('pending').count).to eq(1473)
      expect(ir.find_all_by_status('hot dog!')).to eq([])
    end
  end
  describe '#create' do
    it 'create a new invoice instance' do
      mock_sales_engine = instance_double('SalesEngine')
      ir = InvoiceRepository.new('./data/invoices.csv', mock_sales_engine)
      attributes = {
        id: '1234567890',
        customer_id: '456789',
        merchant_id: '234567890',
        status: 'pending',
        created_at: '2016-01-11 11:51:37 UTC',
        updated_at: '1993-09-29 11:56:40 UTC'
      }
      ir.create(attributes)
      expected = ir.find_by_id(4986)
      expect(expected.merchant_id).to eq(234567890)
    end
  end
  describe '#update' do
    it 'updates invoices attributes' do
      mock_sales_engine = instance_double('SalesEngine')
      ir = InvoiceRepository.new('./data/invoices.csv', mock_sales_engine)
      attributes = {
        status: :success,
        id: 5000,
        customer_id: 2,
        merchant_id: 3,
        created_at: Time.now
        }
      test_invoice = ir.find_by_id(1)
      ir.update(1, attributes)
      expect(test_invoice.id).to eq(1)
      expect(test_invoice.customer_id).to eq(1)
      expect(test_invoice.merchant_id).to eq(12335938)
      expect(test_invoice.status).to eq(:success)
      expect(test_invoice.created_at.year).to eq(2009)
      expect(test_invoice.updated_at.year).to eq(2021)
    end
  end
  describe '#delete' do
    it 'delete a specified invoice from the invoices array' do
      mock_sales_engine = instance_double('SalesEngine')
      ir = InvoiceRepository.new('./data/invoices.csv', mock_sales_engine)
      ir.delete(1)
      expect(ir.invoices.count).to eq(4984)
    end
  end

  describe '#percentage_by_status' do
    it 'shows percent of invoices by status' do
      mock_sales_engine = instance_double('SalesEngine')
      ir = InvoiceRepository.new('./spec/truncated_data/invoices_truncated.csv', mock_sales_engine)

      expect(ir.percentage_by_status(:pending)).to eq(50.00)
      expect(ir.percentage_by_status(:shipped)).to eq(33.33)
      expect(ir.percentage_by_status(:returned)).to eq(16.67)
    end
  end

  describe '#days_by_invoice_count' do
    it 'shows count of invoices per day of week' do
      mock_sales_engine = instance_double('SalesEngine')
      ir = InvoiceRepository.new('./spec/truncated_data/invoices_truncated.csv', mock_sales_engine)

      expect(ir.days_by_invoice_count('Friday')).to eq(2)
      expect(ir.days_by_invoice_count('Wednesday')).to eq(1)
      expect(ir.days_by_invoice_count('SatUrDay')).to eq(2)
      expect(ir.days_by_invoice_count('Tuesday')).to eq(0)
    end
  end

  describe '#invoices_by_days' do
    it 'shows count of invoices per day of week' do
      mock_sales_engine = instance_double('SalesEngine')
      ir = InvoiceRepository.new('./data/invoices.csv', mock_sales_engine)

      expect(ir.invoices_by_days).to eq({"friday"=>701,
                                         "monday"=>696,
                                         "saturday"=>729,
                                         "sunday"=>708,
                                         "thursday"=>718,
                                         "tuesday"=>692,
                                         "wednesday"=>741})
    end
  end

  describe '#average' do
    it 'shows average' do
      mock_sales_engine = instance_double('SalesEngine')
      ir = InvoiceRepository.new('./data/invoices.csv', mock_sales_engine)

      expect(ir.average(ir.invoices_by_days)).to eq(712.1428571428571)
    end
  end

  describe '#hash_variance_from_mean' do
    it 'shows variance from mean' do
      mock_sales_engine = instance_double('SalesEngine')
      ir = InvoiceRepository.new('./data/invoices.csv', mock_sales_engine)

      expect(ir.hash_variance_from_mean(ir.invoices_by_days)).to eq({"friday"=> 124.16326530612173,
                                                                "monday"=> 260.59183673469283,
                                                                "saturday"=> 284.16326530612355,
                                                                "sunday"=> 17.16326530612218,
                                                                "thursday"=> 34.30612244897997,
                                                                "tuesday"=> 405.7346938775497,
                                                                "wednesday"=> 832.7346938775529})
    end
  end

  describe '#standard_deviation' do
    it 'shows standard deviation' do
      mock_sales_engine = instance_double('SalesEngine')
      ir = InvoiceRepository.new('./data/invoices.csv', mock_sales_engine)

      expect(ir.standard_deviation(ir.invoices_by_days)).to eq(18.07)
    end
  end

  describe '#top_sales_days' do
    it 'shows standard deviation' do
      mock_sales_engine = instance_double('SalesEngine')
      ir = InvoiceRepository.new('./data/invoices.csv', mock_sales_engine)

      expect(ir.top_sales_days).to eq(["wednesday"])
    end
  end
end
