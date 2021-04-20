require 'SimpleCOV'
require 'csv'
require './lib/sales_engine'
require './lib/invoice_repository'

RSpec.describe InvoiceRepository do
  describe 'Instance' do
    it 'exists' do
      se = SalesEngine.from_csv(invoices: './data/invoices.csv')
      invoice = se.invoices.find_by_id(6)

      expect(invoice).to be_an_instance_of(Invoice)
    end
    it 'is created with an array of invoices' do
      se = SalesEngine.from_csv(invoices: './data/invoices.csv')

      ir = se.invoices

      expect(ir.all.class).to eq(Array)
      expect(ir.all[0].class).to eq(Invoice)
    end
  end
  describe '#find_all_by_customer_id' do
    it 'finds all customers with passed id' do
      se = SalesEngine.from_csv(invoices: './data/invoices.csv')

      ir = se.invoices
      expect(ir.find_all_by_customer_id(6)[2].id).to eq(26)
    end
  end

  describe '#find_all_by_merchant_id' do
    it 'finds all merchants with passed id' do
      se = SalesEngine.from_csv(invoices: './data/invoices.csv')

      ir = se.invoices
      expect(ir.find_all_by_merchant_id(12335938)[0].id).to eq(1)
    end
  end

  describe '#find_all_by_status' do
    it 'finds all with passed status' do
      se = SalesEngine.from_csv(invoices: './data/invoices.csv')

      ir = se.invoices
      expect(ir.find_all_by_status(:returned)[0].id).to eq(25)
    end
  end

  describe '#create' do
    it 'creates an invoice' do
      se = SalesEngine.from_csv(invoices: './data/invoices.csv')

      ir = se.invoices
      actual = {
        customer_id: '8',
        merchant_id: '10',
        status: 'shipped'
      }
      expect(ir.create(actual)).to be_an_instance_of(Invoice)
    end
  end

  describe '#update' do
    it 'updates the status' do
      se = SalesEngine.from_csv(invoices: './data/invoices.csv')

      ir = se.invoices
      ir.update(38, status: 'shipped')
      expect(ir.find_by_id(38).status).to eq(:shipped)
    end
  end

  describe '#invoices_by_merchant' do
    it "returns a hash of all merchant ids key to their invoices" do
      se = SalesEngine.from_csv(invoices: './data/invoices.csv')

      ir = se.invoices

      expect(ir.invoices_by_merchant).to be_an_instance_of(Hash)
    end
  end

  describe '#find_all_by_date' do
    it "returns the inventory item with the matching date" do
      se = SalesEngine.from_csv(
        invoices: './data/invoices.csv'
      )

      ir = se.invoices
      date = Time.parse('2008-06-29')

      expect(ir.find_all_by_date(date).length).to eq(2)
    end
  end
end
