require 'rspec'
require './lib/invoice_repository'
require './lib/sales_engine'
require 'simplecov'
SimpleCov.start

RSpec.describe InvoiceRepository do
  before(:each) do
    @se = SalesEngine.from_csv({
      :items => './spec/fixtures/item_mock.csv',
      :merchants => './spec/fixtures/merchant_mock.csv',
      :invoices => './spec/fixtures/invoices_mock.csv',
      :invoice_items => './spec/fixtures/invoice_items_mock.csv',
      :customers => './spec/fixtures/customers_mock.csv',
      :transactions => './spec/fixtures/transactions_mock.csv'})
    @ir = InvoiceRepository.new('./spec/fixtures/invoices_mock.csv', @se)
  end

  describe 'instantiation' do
    it 'exists' do

      expect(@ir).to be_an_instance_of(InvoiceRepository)
    end

    it 'has readable attributes' do

      expect(@ir.invoices.count).to eq(0)
      expect(@ir.invoices).to eq([])

      @ir.create_repo

      expect(@ir.invoices.count).to eq(30)
      expect(@ir.invoices[0].id).to eq(1)

    end
  end

  describe 'has a method that can' do
    it 'can create a repo' do
      expect(@ir.invoices.count).to eq(0)
      expect(@ir.invoices).to eq([])

      @ir.create_repo

      expect(@ir.invoices.count).to eq(30)
      expect(@ir.invoices[20].id).to eq(21)
    end

    it 'can return all invoices' do
      @ir.create_repo

      expect(@ir.all.count).to eq(30)
    end

    it 'can find invoices by invoice id' do
      @ir.create_repo

      expect(@ir.find_by_id(20)).to be_an_instance_of(Invoice)
      expect(@ir.find_by_id(20).merchant_id).to eq(12334994)
    end
    it 'can find all invoices by customer by their id number' do
      @ir.create_repo

      expect(@ir.find_all_by_customer_id(15).count).to eq(3)
      expect(@ir.find_all_by_customer_id(11).count).to eq(6)

    end

    it 'can find all invoices by merchant by their id number' do
      @ir.create_repo

      expect(@ir.find_all_by_merchant_id(12334986).count).to eq(10)
      expect(@ir.find_all_by_merchant_id(12334159).count).to eq(2)

    end

    it 'can find all invoices by status' do
      @ir.create_repo

      expect(@ir.find_all_by_status('pending').count).to eq(11)
      expect(@ir.find_all_by_status('shipped').count).to eq(18)

    end

    it 'can create new invoices with readable attributes' do
      @ir.create_repo
      expect(@ir.all.count).to eq(30)

      @ir.create({
                  id: 31,
                  created_at: Time.now.strftime("%Y-%m-%d"),
                  updated_at: Time.now.strftime("%Y-%m-%d")
                  })

      expect(@ir.all.count).to eq(31)
      expect(@ir.all.last.id).to eq(31)
    end

    it 'can update existing invoices' do
      @ir.create_repo
      expect(@ir.find_by_id(15).status).to eq('shipped')

      @ir.update(15, {status: 'not shipped'})

      expect(@ir.find_by_id(15).status).to eq('not shipped')
    end

    it 'can delete by id' do
      @ir.create_repo
      expect(@ir.all.count).to eq(30)
      expect(@ir.all.last.id).to eq(30)

      @ir.delete(30)

      expect(@ir.all.count).to eq(29)
      expect(@ir.all.last.id).to eq(29)
    end
  end
end
