require 'CSV'
require 'invoice_item_repo'

RSpec.describe InvoiceItemRepo do
  describe 'instantiation' do
    it '::new' do
      mock_engine = double('InvoiceItemRepo')
      invoice_item_repo = InvoiceItemRepo.new('./fixtures/mock_invoice_items.csv', mock_engine)

      expect(invoice_item_repo).to be_an_instance_of(InvoiceItemRepo)
    end
  end

  describe '#methods' do
    it '#all' do
      mock_engine = double('InvoiceItemRepo')
      invoice_item_repo = InvoiceItemRepo.new('./fixtures/mock_invoice_items.csv', mock_engine)

      expect(invoice_item_repo.all).to be_an_instance_of(Array)
    end

    it '#find_by_id' do
      mock_engine = double('InvoiceItemRepo')
      invoice_item_repo = InvoiceItemRepo.new('./fixtures/mock_invoice_items.csv', mock_engine)
      collection = invoice_item_repo.invoice_items
      invoice_item = invoice_item_repo.create({:id          => 9000,
                                               :item_id     => 7,
                                               :invoice_id  => 8,
                                               :quantity    => 1,
                                               :unit_price  => BigDecimal(10.99,4),
                                               :created_at  => Time.now,
                                               :updated_at  => Time.now
                                          })

      expect(invoice_item_repo.find_by_id(invoice_item.id, collection)).to eq(invoice_item)
      expect(invoice_item_repo.find_by_id(1000, collection)).to eq(nil)
    end

    it '#find_all_by_item_id' do
      mock_engine = double('InvoiceItemRepo')
      invoice_item_repo = InvoiceItemRepo.new('./fixtures/mock_invoice_items.csv', mock_engine)
      collection = invoice_item_repo.invoice_items
      invoice_item = invoice_item_repo.create({:id          => 9000,
                                               :item_id     => 7,
                                               :invoice_id  => 8,
                                               :quantity    => 1,
                                               :unit_price  => BigDecimal(10.99,4),
                                               :created_at  => Time.now,
                                               :updated_at  => Time.now
                                          })

      expect(invoice_item_repo.find_all_by_item_id(7, collection)).to eq([invoice_item])
      expect(invoice_item_repo.find_all_by_item_id(999999999, collection)).to eq([])
    end

    it '#find_all_by_invoice_id' do
      mock_engine = double('InvoiceItemRepo')
      invoice_item_repo = InvoiceItemRepo.new('./fixtures/mock_invoice_items.csv', mock_engine)
      collection = invoice_item_repo.invoice_items
      invoice_item = invoice_item_repo.create({:id          => 9000,
                                              :item_id     => 7,
                                              :invoice_id  => 8,
                                              :quantity    => 1,
                                              :unit_price  => BigDecimal(10.99,4),
                                              :created_at  => Time.now,
                                              :updated_at  => Time.now
                                              })

       expect(invoice_item_repo.find_all_by_invoice_id(8, collection)).to eq([invoice_item])
       expect(invoice_item_repo.find_all_by_invoice_id(999999999, collection)).to eq([])
      end

    it '#create' do
      mock_engine = double('InvoiceItemRepo')
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
      mock_engine = double('InvoiceItemRepo')
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

      invoice_item_repo.update(invoice_item.id, updated_attributes)

      expect(invoice_item.quantity).to eq(10)
      expect(invoice_item.unit_price).to eq(15.99)
      expect(invoice_item.updated_at).to be_an_instance_of(Time)
    end

    it '#delete' do
      mock_engine = double('InvoiceItemRepo')
      invoice_item_repo = InvoiceItemRepo.new('./fixtures/mock_invoices.csv', mock_engine)
      invoice_item = invoice_item_repo.create({:id => 0,
                                   :customer_id => 7,
                                   :merchant_id => 8,
                                   :status => 'pending',
                                   :created_at => Time.now,
                                   :updated_at => Time.now})

      expect(invoice_item_repo.all.length).to eq(11)

      invoice_item_repo.delete(invoice_item.id)

      expect(invoice_item_repo.all.length).to eq(10)
    end
  end
end
