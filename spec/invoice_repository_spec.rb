require './lib/requirements'

RSpec.describe InvoiceRepository do
  let!(:invoice_repository) {InvoiceRepository.new('./data/invoices.csv', nil)}

  it 'is a invoice repository class' do
    expect(invoice_repository).to be_a(InvoiceRepository)
  end

  it 'can return all invoices' do
    expect(invoice_repository.all.length).to eq 4985
  end

  it 'can return an invoice associated to the given id' do
    invoice_id = 3452
    expected = invoice_repository.find_by_id(invoice_id)

    expect(expected.id).to eq invoice_id
    expect(expected.merchant_id).to eq 12335690
    expect(expected.customer_id).to eq 679
    expect(expected.status).to eq :pending

    invoice_id = 5000
    expected = invoice_repository.find_by_id(invoice_id)

    expect(expected).to eq nil
  end

  it 'can return all invoices associated with given customer id' do
    expect(invoice_repository.find_all_by_customer_id(300).length).to eq 10
    expect(invoice_repository.find_all_by_customer_id(1000)).to eq([])
  end

  it 'can return all invoices associated with given merchant id' do
    expect(invoice_repository.find_all_by_merchant_id(12335080).length).to eq 7
    expect(invoice_repository.find_all_by_merchant_id(1000)).to eq([])
  end

  it 'can return all invoices associated with given status' do
    status = :shipped
    expect(invoice_repository.find_all_by_status(status).length).to eq 2839

    status = :pending
    expect(invoice_repository.find_all_by_status(status).length).to eq 1473

    status = :sold
    expect(invoice_repository.find_all_by_status(status)).to eq []
  end

  it 'can create a new invoice instance' do
    attributes = {
      :customer_id => 7,
      :merchant_id => 8,
      :status      => 'pending',
      :created_at  => Time.now.to_s,
      :updated_at  => Time.now.to_s,
    }
    invoice_repository.create(attributes)
    expected = invoice_repository.find_by_id(4986)
    expect(expected.merchant_id).to eq 8
  end

  it 'can update an invoice' do
    original_time = invoice_repository.find_by_id(4985).updated_at
    attributes = {
      status: :success
    }
    invoice_repository.update(4985, attributes)
    expect(invoice_repository.find_by_id(4985).status).to eq :success
    expect(invoice_repository.find_by_id(4985).customer_id).to eq 999
    expect(invoice_repository.find_by_id(4985).updated_at).not_to be original_time
  end

  it 'cannot update id, customer_id, merchant_id, or created_at when it gets updated' do
    attributes = {
      id: 5000,
      customer_id: 2,
      merchant_id: 3,
      created_at: Time.now
    }
    invoice_repository.update(4985, attributes)
    invoice_repository.find_by_id(5000)
    expect(invoice_repository.find_by_id(5000)).to eq nil

    invoice_repository.find_by_id(4985)
    expect(invoice_repository.find_by_id(4985).customer_id).not_to eq attributes[:customer_id]
    expect(invoice_repository.find_by_id(4985).merchant_id).not_to eq attributes[:merchant_id]
    expect(invoice_repository.find_by_id(4985).created_at).not_to eq attributes[:created_at]
  end

  it 'will do nothing if it tries to update an unknown invoice' do
    invoice_repository.update(5000, {})
  end

  it 'can delete a specified invoice' do
    invoice_repository.delete(4985)
    expected = invoice_repository.find_by_id(4985)
    expect(expected).to eq nil
  end

  it 'will not delete anything if the invoice is unknown' do
    invoice_repository.delete(5000)
  end

  def inspect
    '#<#{self.class} #{@merchants.size} rows>'
  end
end