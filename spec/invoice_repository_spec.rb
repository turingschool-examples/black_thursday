require_relative '../lib/invoice_repository'
require_relative '../lib/invoice'

RSpec.describe InvoiceRepository do
  let(:invoice_repository) { InvoiceRepository.new }

  let(:invoice_1) { Invoice.new({ id: 6,
                                  customer_id: 7,
                                  merchant_id: 8,
                                  status: 'pending',
                                  created_at: Time.now,
                                  updated_at: Time.now
                                }) }

  let(:invoice_2) { Invoice.new({ id: 1,
                                  customer_id: 2,
                                  merchant_id: 3,
                                  status: 'shipped',
                                  created_at: Time.now,
                                  updated_at: Time.now
                                }) }

  let(:invoice_3) { Invoice.new({ id: 4,
                                  customer_id: 2,
                                  merchant_id: 3,
                                  status: 'returned',
                                  created_at: Time.now,
                                  updated_at: Time.now
                                }) }

  let(:invoice_4) { Invoice.new({ id: 2,
                                  customer_id: 8,
                                  merchant_id: 5,
                                  status: 'returned',
                                  created_at: Time.now,
                                  updated_at: Time.now
                                }) }

  describe '#initialize' do
    it 'exist' do
      expect(invoice_repository).to be_a(InvoiceRepository)
    end
  end

  describe 'all' do
    it 'starts as an empty array' do
      expect(invoice_repository.all).to eq([])
    end
  end

  describe '#find_by_id' do
    it 'returns an instance of invoice with a matching id' do
      invoice_repository.add_to_repo(invoice_1)
      invoice_repository.add_to_repo(invoice_2)

      expect(invoice_repository.find_by_id(6)).to eq(invoice_1)
      expect(invoice_repository.find_by_id(1)).to eq(invoice_2)
      expect(invoice_repository.find_by_id(9)).to be_nil
    end
  end

  describe '#find_all_by_customer_id' do
    it 'returns empty array or all invoices with matching customer_id' do
      invoice_repository.add_to_repo(invoice_1)
      invoice_repository.add_to_repo(invoice_2)
      invoice_repository.add_to_repo(invoice_3)

      expect(invoice_repository.find_all_by_customer_id(7)).to eq([invoice_1])
      expect(invoice_repository.find_all_by_customer_id(2)).to eq([invoice_2, invoice_3])
      expect(invoice_repository.find_all_by_customer_id(4)).to eq([])
    end
  end

  describe '#find_all_by_merchant_id' do
    it 'returns empty array or all invoices with matching merchant_id' do
      invoice_repository.add_to_repo(invoice_1)
      invoice_repository.add_to_repo(invoice_2)
      invoice_repository.add_to_repo(invoice_3)

      expect(invoice_repository.find_all_by_merchant_id(8)).to eq([invoice_1])
      expect(invoice_repository.find_all_by_merchant_id(3)).to eq([invoice_2, invoice_3])
      expect(invoice_repository.find_all_by_merchant_id(4)).to eq([])
    end
  end

  describe '#find_all_by_status' do
    it 'returns empty array or all invoices with matching status' do
      invoice_repository.add_to_repo(invoice_1)
      invoice_repository.add_to_repo(invoice_2)
      invoice_repository.add_to_repo(invoice_3)
      invoice_repository.add_to_repo(invoice_4)

      expect(invoice_repository.find_all_by_status(:pending)).to eq([invoice_1])
      expect(invoice_repository.find_all_by_status(:shipped)).to eq([invoice_2])
      expect(invoice_repository.find_all_by_status(:returned)).to eq([invoice_3, invoice_4])
      expect(invoice_repository.find_all_by_status(:doesntexist)).to eq([])
    end
  end

  describe '#create' do
    it 'can create a new invoice' do
      expect(invoice_repository.all).to eq([])

      invoice_repository.create({ customer_id: 8,
                                  merchant_id: 5,
                                  status: 'returned',
                                  created_at: Time.now,
                                  updated_at: Time.now })

      expect(invoice_repository.all.first.id).to eq(1)

      invoice_repository.create({ customer_id: 18,
                                  merchant_id: 15,
                                  status: 'returned',
                                  created_at: Time.now,
                                  updated_at: Time.now })


      expect(invoice_repository.all[1].id).to eq(2)
      expect(invoice_repository.all.size).to eq(2)
    end
  end

  describe '#update' do
    it 'can update status' do
      invoice_repository.add_to_repo(invoice_1)
      invoice_repository.add_to_repo(invoice_2)
      invoice_repository.add_to_repo(invoice_3)

      expect(invoice_repository.all[0].status).to eq(:pending)
      expect(invoice_repository.all[1].status).to eq(:shipped)
      expect(invoice_repository.all[2].status).to eq(:returned)

      invoice_repository.update( 6, {status: 'Canceled'})
      invoice_repository.update( 1, {status: 'Returned'})
      invoice_repository.update( 4, {status: 'Shipped'})

      expect(invoice_repository.all[0].status).to eq('Canceled')
      expect(invoice_repository.all[1].status).to eq('Returned')
      expect(invoice_repository.all[2].status).to eq('Shipped')
    end
  end

  describe '#delete' do
    it 'deletes the invoice with the corresponding id' do
      invoice_repository.add_to_repo(invoice_1)
      invoice_repository.add_to_repo(invoice_2)
      invoice_repository.add_to_repo(invoice_3)

      expect(invoice_repository.all.size).to eq(3)

      invoice_repository.delete(6)
      expect(invoice_repository.all.size).to eq(2)

      invoice_repository.delete(1)
      expect(invoice_repository.all[0].customer_id).to eq(2)
      expect(invoice_repository.all.size).to eq(1)
    end


   it 'cannot delete an id that does not exist' do
      invoice_repository.add_to_repo(invoice_1)
      invoice_repository.add_to_repo(invoice_2)
      invoice_repository.add_to_repo(invoice_3)


      expect(invoice_repository.all.size).to eq(3)

      invoice_repository.delete(12)

      expect(invoice_repository.all.size).to eq(3)
      expect(invoice_repository.all[0].customer_id).to eq(7)
    end
  end
end
