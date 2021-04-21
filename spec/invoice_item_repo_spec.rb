require 'CSV'
require 'sales_engine'
require 'invoice_item_repo'

RSpec.describe InvoiceItemRepo do

  describe 'instantiation' do
    it '::new' do
      invoice_item_repo = InvoiceItemRepo.new('./data/invoice_items.csv', nil)

      expect(invoice_item_repo).to be_an_instance_of(InvoiceItemRepo)
    end
  end

  describe '#methods' do
    it '#all returns an array of all invoice item instances' do
      invoice_item_repo = InvoiceItemRepo.new('./data/invoice_items.csv', nil)

      expect(invoice_item_repo.all).to be_an_instance_of(Array)
    end

    it '#find_by_id finds an invoice_item by id' do
      mock_engine = double("SalesEngine")
      invoice_item_repo = InvoiceItemRepo.new('./data/invoice_items.csv', mock_engine)
      invoice_item = invoice_item_repo.create({:
                                               :item_id => 7,
                                               :invoice_id => 8,
                                               :quantity => 1,
                                               :unit_price => BigDecimal(10.99, 4),
                                               :created_at => Time.now,
                                               :updated_at => Time.now
                                        })
      expect(invoice_item_repo.find_by_id(invoice_item.id)).to eq(invoice_item)
    end

    # xit '#find_by_id finds an invoice_item by id' do
    #   mock_engine = double("SalesEngine")
    #   invoice_item_repo = InvoiceItemRepo.new('./data/invoice_items.csv', mock_engine)
    #   invoice_item = invoice_item_repo.create({:id          => 9000,
    #                                            :item_id     => 7,
    #                                            :invoice_id  => 8,
    #                                            :quantity    => 1,
    #                                            :unit_price  => BigDecimal(10.99,4),
    #                                            :created_at  => Time.now,
    #                                            :updated_at  => Time.now
    #                                      })

    #   expect(invoice_item_repo.find_by_id(9000)).to eq(invoice_item)
    # end
    
    # xit '#find_by_id returns nil if the invoice item does not exist' do
    #   id = 200000
    #   expected = invoice_items.find_by_id(id)
    #
    #   expect(invoice_items).to eq nil
    # end
    #
    # xit 'find_all_by_item_id finds all items matching given item_id' do
    #   item_id = 263408101
    #   expected = invoice_items.find_all_by_item_id(item_id)
    #
    #   expect(invoice_item_repo.length).to eq 11
    #   expect(invoice_item_repo.first.class).to eq InvoiceItem
    # end
    #
    # xit '#find_all_by_item_id returns an empty array if there are no matches' do
    #   invoice_item_repo = @sales_engine.invoice_items
    #
    #   expect(invoice_item_repo.length).to eq 0
    #   expect(invoice_item_repo.empty?).to eq true
    # end
    #
    # xit '#find_all_by_invoice_id finds all items matching a given item_id' do
    #   invoice_id = 100
    #   expected = invoice_items.find_all_by_invoice_id(invoice_id)
    #
    #   expect(expected.length).to eq 3
    #   expect(expected.first.class).to eq InvoiceItem
    # end
    #
    # xit '#find_all_by_invoice_id returns an empty array if there are no matches' do
    #   invoice_id = 1234567890
    #   expected = invoice_items.find_all_by_invoice_id(invoice_id)
    #
    #   expect(invoice_item_repo.length).to eq 0
    #   expect(invoice_item_repo.empty?).to eq true
    # end

    it '#create creates a new invoice item instance' do
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
 
    # it '#create creates a new invoice item instance' do
    #   mock_engine = double("SalesEngine")
    #   invoice_item_repo = InvoiceItemRepo.new('./data/invoice_items.csv', mock_engine)
    #   attributes = {
    #     :item_id => 7,
    #     :invoice_id => 8,
    #     :quantity => 1,
    #     :unit_price => BigDecimal(10.99, 4),
    #     :created_at => Time.now,
    #     :updated_at => Time.now
    #   }
    #   require 'pry'; binding.pry
    #   expect(invoice_item_repo.create(attributes)).to be_an_instance_of(InvoiceItem)
    # end

    it '#update attributes' do
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

    it '#update updates an invoice item' do
      original_time = invoice_items.find_by_id(21831).updated_at
      attributes = {
        quantity: 13
      }
      invoice_items.update(21831, attributes)
      expected = invoice_items.find_by_id(21831)
      expect(invoice_items.quantity).to eq 13
      expect(invoice_items.item_id).to eq 7
      expect(invoice_items.updated_at).to be > original_time
    end
    
    it '#update cannot update id, item_id, invoice_id, or created_at' do
      attributes = {
        id: 22000,
        item_id: 32,
        invoice_id: 53,
        created_at: Time.now
      }
      invoice_items.update(21831, attributes)
      expected = invoice_items.find_by_id(22000)
      expect(invoice_items).to eq nil
      expected = invoice_items.find_by_id(21831)
      expect(invoice_item_repo.item_id).not_to eq attributes[:item_id]
      expect(invoice_item_repo.invoice_id).not_to eq attributes[:invoice_id]
      expect(invoice_item_repo.created_at).not_to eq attributes[:created_at]
    end
    
    it '#update on unknown invoice item does nothing' do
      invoice_items.update(22000, {})
    end

    it '#delete deletes the specified invoice' do
      invoice_items.delete(21831)
      expected = invoice_items.find_by_id(21831)
      expect(invoice_items).to eq nil
    end

    it 'delete on unknown invoice does nothing' do
      invoice_items.delete(22000)
    end
  end
end
