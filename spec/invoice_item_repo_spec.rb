require 'CSV'
require 'invoice_item_repo'

RSpec.describe InvoiceItemRepo do

  describe 'instantiation' do
    it '::new' do
      mock_repo = double('InvoiceItemRepo')
      invoice_item_repo = InvoiceItemRepo.new('./fixtures/invoice_items.csv', mock_engine)
      
      expect(invoice_item_repo).to be_an_instance_of(InvoiceItemRepo)
    end
  end

  describe '#methods' do
    it '#all' do
      mock_repo = double('InvoiceItemRepo')
      invoice_item_repo = InvoiceItemRepo.new('./fixtures/invoice_items.csv', mock_engine)


      expect(invoice_item_repo.all).to be_an_instance_of(Array)
    end

    it '#find_by_id' do
      mock_engine = double("SalesEngine")
      invoice_item_repo = InvoiceItemRepo.new('./fixtures/invoice_items.csv', mock_engine)
      invoice_item = invoice_item_repo.create({:item_id => 7,
                                               :invoice_id => 8,
                                               :quantity => 1,
                                               :unit_price => BigDecimal(10.99, 4),
                                               :created_at => Time.now,
                                               :updated_at => Time.now
                                        })
      expect(invoice_item_repo.find_by_id(invoice_item.id)).to eq(invoice_item)
    end
      
    xit '#find_by_id' do
      mock_engine = double("SalesEngine")
      invoice_item_repo = InvoiceItemRepo.new('./fixtures/invoice_items.csv', mock_engine)
      invoice_item = invoice_item_repo.create({:id          => 9000,
                                               :item_id     => 7,
                                               :invoice_id  => 8,
                                               :quantity    => 1,
                                               :unit_price  => BigDecimal(10.99,4),
                                               :created_at  => Time.now,
                                               :updated_at  => Time.now})
      expect(invoice_item_repo(9000)).to eq ()
    end

    xit '#find_by_id' do
      mock_engine = double("SalesEngine")
      invoice_item_repo = InvoiceItemRepo.new('./fixtures/invoice_items.csv', mock_engine)
      invoice_item = invoice_item_repo.create({:id          => 9000,
                                               :item_id     => 7,
                                               :invoice_id  => 8,
                                               :quantity    => 1,
                                               :unit_price  => BigDecimal(10.99,4),
                                               :created_at  => Time.now,
                                               :updated_at  => Time.now
                                          })

      expect(invoice_item_repo.find_by_id(9000)).to eq(invoice_item)
      expect(invoice_item_repo.find_by_id(1000)).to eq(nil)
    end
    
    xit '#find_all_by_item_id' do
        mock_engine = double("SalesEngine")
        invoice_item_repo = InvoiceItemRepo.new('./fixtures/invoice_items.csv', mock_engine)
    
       expect(invoice_item_repo.length).to eq 11
       expect(invoice_item_repo.first.class).to eq InvoiceItem
     end
    
    xit '#find_all_by_item_id returns an empty array if there are no matches' do
      mock_engine = double("SalesEngine")
      invoice_item_repo = InvoiceItemRepo.new('./fixtures/invoice_items.csv', mock_engine)

      expect(invoice_item_repo.length).to eq 0
      expect(invoice_item_repo.empty?).to eq true
    end
    
    xit '#find_all_by_invoice_id finds all items matching a given item_id' do
      mock_engine = double("SalesEngine")
      invoice_item_repo = InvoiceItemRepo.new('./fixtures/invoice_items.csv', mock_engine)

      expected = invoice_items.find_all_by_invoice_id(invoice_id)
    
      expect(expected.length).to eq 3
      expect(expected.first.class).to eq InvoiceItem
    end
    
    xit '#find_all_by_invoice_id returns an empty array if there are no matches' do
      mock_engine = double("SalesEngine")
      invoice_item_repo = InvoiceItemRepo.new('./fixtures/invoice_items.csv', mock_engine)
    
      expect(invoice_item_repo.length).to eq 0
      expect(invoice_item_repo.empty?).to eq true
    end

    it '#create' do
      mock_engine = double("SalesEngine")
      invoice_item_repo = InvoiceItemRepo.new('./data/invoice_items.csv', mock_engine)
      attributes = {
                    :item_id => 7,
                    :invoice_id => 8,
                    :quantity => 1,
                    :unit_price => BigDecimal(10.99, 4),
                    :created_at => Time.now,
                    :updated_at => Time.now
      }

      expect(invoice_item_repo.create(attributes)).to be_an_instance_of(InvoiceItem)
    end
 
    it '#update' do
      mock_engine = double("SalesEngine")
      invoice_item_repo = InvoiceItemRepo.new('./data/invoice_items.csv', mock_engine)
      invoice_item = invoice_item_repo.create({:item_id => 7,
                                               :invoice_id => 8,
                                               :quantity => 1,
                                               :unit_price => 1099,
                                               :created_at => Time.now,
                                               :updated_at => Time.now})

      updated_attributes = {:quantity => 10,
                            :unit_price => BigDecimal(15.99, 4),
                            :updated_at  => Time.now}

      invoice_item_repo.update(item.id, updated_attributes)

      expect(invoice_item.quantity).to eq(10)
      expect(invoice_item.unit_price).to eq(15.99)
      expect(invoice_item.updated_at).to be_an_instance_of(Time)
    end

    it '#delete' do
      mock_engine = double('InvoiceRepo')
      invoice_item_repo = InvoiceRepo.new('./fixtures/mock_invoices.csv', mock_engine) 
      invoice_item = invoice_item_repo.create({:id => 0,
                                   :customer_id => 7,
                                   :merchant_id => 8,
                                   :status => 'pending',
                                   :created_at => Time.now,
                                   :updated_at => Time.now})

      expect(invoice_repo.all.length).to eq(4986)

      invoice_item_repo.delete(invoice.id)

      expect(invoice_repo.all.length).to eq(4985)
    end
  end
end
