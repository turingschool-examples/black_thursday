require './spec_helper'
require './lib/sales_engine'

RSpec.describe SalesEngine do
  describe '#initialize' do
    it 'exists' do
      se = SalesEngine.new({
        :items     => './data/items.csv',
        :merchants => './data/merchants.csv'})

      expect(se).to be_a(SalesEngine)
    end
  end

  describe '#from_csv' do
    it 'returns a SalesEngine object' do
      se = SalesEngine.from_csv({
        :items     => './data/items.csv',
        :merchants => './data/merchants.csv'})

      expect(se).to be_a(SalesEngine)
    end
  end

  describe '#create_item_repo' do
    it 'creates an item repository object and stores in instance variable' do
      se = SalesEngine.from_csv({
        :items     => './data/items.csv',
        :merchants => './data/merchants.csv'})
      ir = se.items

      expect(ir).to be_a(ItemRepository)
    end

    it 'contains the data from the csv file' do
      se = SalesEngine.from_csv({
        :items     => './data/items.csv',
        :merchants => './data/merchants.csv'})
      ir = se.items

      expect(ir.find_by_id(263395237)).to be_a(Item)
      expect(ir.find_by_id(263395237).name).to eq("510+ RealPush Icon Set")
      expect(ir.find_by_name("HOT Crystal Dragon Fly Hand Blown Glass Art Gold Trim Figurine Lucky Collection")).to be_a(Item)
      expect(ir.find_by_id(1)).to eq(nil)
    end
  end

  describe '#create_merchant_repo' do
    it 'creates a merchant repository object and stores in instance variable' do
      se = SalesEngine.from_csv({
        :items     => './data/items.csv',
        :merchants => './data/merchants.csv'})
      mr = se.merchants

      expect(mr).to be_a(MerchantRepository)
    end

    it 'contains the data from the csv file' do
      se = SalesEngine.from_csv({
        :items     => './data/items.csv',
        :merchants => './data/merchants.csv'})
      mr = se.merchants

      expect(mr.find_by_id(12334105)).to be_a(Merchant)
      expect(mr.find_by_id(12334105).name).to eq("Shopin1901")
      expect(mr.find_by_name("SassyStrangeArt")).to be_a(Merchant)
      expect(mr.find_by_id(1)).to eq(nil)
    end
  end

  describe '#create_invoice_repo' do
    it 'creates an invoice repository object and stores in instance variable' do
      se = SalesEngine.from_csv({
        :items     => './data/items.csv',
        :merchants => './data/merchants.csv',
        :invoices => './data/invoices.csv'})
      invoice_repo = se.invoices

      expect(invoice_repo).to be_a(InvoiceRepository)
    end

    it 'contains the data from the csv file' do
      se = SalesEngine.from_csv({
        :items     => './data/items.csv',
        :merchants => './data/merchants.csv',
        :invoices => './data/invoices.csv'})
      invoice_repo = se.invoices

      expect(invoice_repo.find_by_id(1)).to be_a(Invoice)
      expect(invoice_repo.find_by_id(720)).to be_a(Invoice)
      expect(invoice_repo.find_by_id(123123123)).to eq(nil)
    end
  end
  
  describe '#create_invoice_item_repo' do
    it 'creates an invoice item repository object and stores in instance variable' do
      se = SalesEngine.from_csv({
        :invoice_items => './data/invoice_items.csv'})
      invoice_item_repo = se.invoice_items

      expect(invoice_item_repo).to be_a(InvoiceItemRepository)
    end
  end
end
