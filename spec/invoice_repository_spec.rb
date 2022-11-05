require_relative '../lib/invoice_repository'
require_relative '../lib/invoice'
require_relative '../lib/merchant'
require_relative '../lib/sales_engine'

RSpec.describe InvoiceRepository do
  it 'exists' do
    ivr = InvoiceRepository.new

    expect(ivr).to be_a(InvoiceRepository)
  end  

  it 'starts with no invoices' do
    ivr = InvoiceRepository.new

    expect(ivr.data).to eq([])
  end
  describe '#module methods' do
    it 'can return all invoices' do
      ivr = InvoiceRepository.new
  
      i = Invoice.new(
        :id          => 6,
        :customer_id => 7,
        :merchant_id => 8,
        :status      => "pending",
        :created_at  => created = Time.now.to_s,
        :updated_at  => updated = Time.now.to_s
      )
  
      ivr.all << i 
  
      expect(ivr.all).to eq([i])
    end

    it 'can find invoices by id' do
      ivr = InvoiceRepository.new
      i = Invoice.new(
        :id          => 6,
        :customer_id => 7,
        :merchant_id => 8,
        :status      => "pending",
        :created_at  => created = Time.now.to_s,
        :updated_at  => updated = Time.now.to_s
      )

      ivr.all << i 

      expect(ivr.find_by_id(6)).to eq(i)
      expect(ivr.find_by_id(2)).to eq(nil)
    end

    it 'can find all invoices by merchant id' do
      ivr = InvoiceRepository.new
      i1 = Invoice.new(
        :id          => 6,
        :customer_id => 7,
        :merchant_id => 8,
        :status      => "pending",
        :created_at  => created = Time.now.to_s,
        :updated_at  => updated = Time.now.to_s
      )
      i2 = Invoice.new(
        :id          => 5,
        :customer_id => 7,
        :merchant_id => 8,
        :status      => "pending",
        :created_at  => created = Time.now.to_s,
        :updated_at  => updated = Time.now.to_s
      )
      i3 = Invoice.new(
        :id          => 5,
        :customer_id => 7,
        :merchant_id => 10,
        :status      => "pending",
        :created_at  => created = Time.now.to_s,
        :updated_at  => updated = Time.now.to_s
      )

      ivr.all.push(i1,i2,i3)

      expect(ivr.all).to eq([i1,i2,i3])
      expect(ivr.find_all_by_merchant_id(8)).to eq([i1,i2])
    end

    it 'can delete invoices' do
      ivr = InvoiceRepository.new
      i = Invoice.new(
        :id          => 6,
        :customer_id => 7,
        :merchant_id => 8,
        :status      => "pending",
        :created_at  => created = Time.now.to_s,
        :updated_at  => updated = Time.now.to_s
      )

      ivr.all << i 

      expect(ivr.all).to eq([i])

      ivr.delete(6)

      expect(ivr.all).to eq([])
    end
  end

  it 'can have an engine' do
    se = SalesEngine.new({:invoices => "./data/invoices.csv"})
    ivr = InvoiceRepository.new(nil, se)

    expect(ivr.engine).to be_a(SalesEngine)
  end

  it 'can find invoices by customer id' do
    ivr = InvoiceRepository.new
      i1 = Invoice.new(
        :id          => 6,
        :customer_id => 8,
        :merchant_id => 8,
        :status      => 'pending',
        :created_at  => created = Time.now.to_s,
        :updated_at  => updated = Time.now.to_s
      )
      i2 = Invoice.new(
        :id          => 5,
        :customer_id => 8,
        :merchant_id => 8,
        :status      => 'pending',
        :created_at  => created = Time.now.to_s,
        :updated_at  => updated = Time.now.to_s
      )
      i3 = Invoice.new(
        :id          => 7,
        :customer_id => 9,
        :merchant_id => 10,
        :status      => 'pending',
        :created_at  => created = Time.now.to_s,
        :updated_at  => updated = Time.now.to_s
      )

      ivr.all.push(i1,i2,i3)

      expect(ivr.all).to eq([i1,i2,i3])
      expect(ivr.find_all_by_customer_id(8)).to eq([i1,i2])
  end

  it 'find all invoices by status' do
    ivr = InvoiceRepository.new
      i1 = Invoice.new(
        :id          => 6,
        :customer_id => 8,
        :merchant_id => 8,
        :status      => 'pending',
        :created_at  => created = Time.now.to_s,
        :updated_at  => updated = Time.now.to_s
      )
      i2 = Invoice.new(
        :id          => 5,
        :customer_id => 8,
        :merchant_id => 8,
        :status      => 'pending',
        :created_at  => created = Time.now.to_s,
        :updated_at  => updated = Time.now.to_s
      )
      i3 = Invoice.new(
        :id          => 7,
        :customer_id => 9,
        :merchant_id => 10,
        :status      => 'completed',
        :created_at  => created = Time.now.to_s,
        :updated_at  => updated = Time.now.to_s
      )

      ivr.all.push(i1,i2,i3)

      expect(ivr.all).to eq([i1,i2,i3])
      expect(ivr.find_all_by_status('pending')).to eq([i1,i2])
  end

  it 'can create a new invoice' do
    ivr = InvoiceRepository.new
      i1 = Invoice.new(
        :id          => 6,
        :customer_id => 8,
        :merchant_id => 8,
        :status      => 'pending',
        :created_at  => created = Time.now.to_s,
        :updated_at  => updated = Time.now.to_s
      )
      i2 = Invoice.new(
        :id          => 5,
        :customer_id => 8,
        :merchant_id => 8,
        :status      => 'pending',
        :created_at  => created = Time.now.to_s,
        :updated_at  => updated = Time.now.to_s
      )
      i3 = Invoice.new(
        :id          => 7,
        :customer_id => 9,
        :merchant_id => 10,
        :status      => 'completed',
        :created_at  => created = Time.now.to_s,
        :updated_at  => updated = Time.now.to_s
      )

      ivr.all.push(i1,i2,i3)

      ivr.create(
        :id          => 7,
        :customer_id => 9,
        :merchant_id => 10,
        :status      => 'completed',
        :created_at  => created = Time.now.to_s,
        :updated_at  => updated = Time.now.to_s
      )

      expect(ivr.all[-1].id).to eq(8)
      expect(ivr.all[-1]).to be_a(Invoice)
  end

  it 'can update invoices status and update time only' do
    ivr = InvoiceRepository.new
  
      i = Invoice.new(
        :id          => 6,
        :customer_id => 7,
        :merchant_id => 8,
        :status      => "pending",
        :created_at  => created = Time.now.to_s,
        :updated_at  => updated = Time.now.to_s
      )
  
      ivr.all << i 
      expect(i.updated_at).to eq(Time.parse(updated))

      ivr.update(6, status: "completed")

      expect(i.status).to eq("completed")
      expect(i.updated_at).not_to eq(Time.parse(updated))
  end
end
