require 'csv'
require './lib/sales_engine'
require './lib/repository'

RSpec.describe Repository do
  before(:all) do
    se = SalesEngine.from_csv(
      merchants: './data/merchants.csv',
      invoices: './data/invoices.csv',
      customers: './data/customers.csv',
      items: './data/items.csv',
      invoice_items: './data/invoice_items.csv'
    )
    @mr = se.merchants
    @inv = se.invoices
    @cr = se.customers
    @ir = se.items
    @iir = se.invoice_items
  end
  describe 'Instance' do
    it 'exists' do
      rep = Repository.new([], 'engine')

      expect(rep).to be_an_instance_of(Repository)
    end
  end

  describe '#all' do
    it 'returns everything in its array' do

      expect(@mr.all[0].name).to eq('Shopin1901')
      expect(@inv.all[0].id).to eq(1)
      expect(@cr.all[0].id).to eq(1)
      expect(@ir.all[0].id).to eq(263395237)
      expect(@iir.all[0].id).to eq(1)
    end
  end

  describe '#find_by_id' do
    it 'finds by id' do


      expect(@mr.find_by_id(12335573).name).to eq('retropostershop')
      expect(@inv.find_by_id(2179).id).to eq(2179)
      expect(@cr.find_by_id(12335938)).to eq(nil)
      expect(@ir.find_by_id(2179)).to eq(nil)
      expect(@iir.find_by_id(12335573)).to eq(nil)
    end

    it 'returns nil if no id' do

      expect(@mr.find_by_id(2113113113)).to eq(nil)
      expect(@inv.find_by_id(2113113113)).to eq(nil)
      expect(@cr.find_by_id(2113113113)).to eq(nil)
      expect(@ir.find_by_id(2113113113)).to eq(nil)
      expect(@iir.find_by_id(2113113113)).to eq(nil)
    end
  end

  describe '#find_by_name' do
    it 'finds a merchant by name' do

      expect(@mr.find_by_name('retropostershop').id).to eq(12335573)
    end

    it 'returns nil if no name exists' do

      expect(@mr.find_by_name('lawrencesmeademporium')).to eq(nil)
    end
  end

  describe '#max_id_number_new' do
    it 'finds the current max id' do

      expect(@mr.max_id_number_new).to eq(12337412)
      expect(@inv.max_id_number_new).to eq(4986)
      expect(@cr.max_id_number_new).to eq(1001)
      expect(@ir.max_id_number_new).to eq(263567475)
      expect(@iir.max_id_number_new).to eq(21831)
    end
  end

  describe '#delete' do
    it 'deletes via id' do

      @mr.delete(12337411)
      @inv.delete(12337411)
      @cr.delete(12337411)
      @ir.delete(12337411)
      @iir.delete(12337411)

      expect(@mr.find_by_id(12337411)).to eq(nil)
      expect(@inv.find_by_id(12337411)).to eq(nil)
      expect(@cr.find_by_id(12337411)).to eq(nil)
      expect(@ir.find_by_id(12337411)).to eq(nil)
      expect(@iir.find_by_id(12337411)).to eq(nil)
    end
  end
end
