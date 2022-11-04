require_relative '../lib/invoice_repository'

RSpec.describe InvoiceRepository do
  it 'exists and has no invoices by default' do
    invr = InvoiceRepository.new

    expect(invr).to be_a(InvoiceRepository)
    expect(invr.invoices).to eq([])
  end

  it 'can find all' do
    expect(engine.invoices.all.first).to be_a Invoice
    expect(engine.invoices.all).to be_a Array
  end

  it 'can find by id' do
    expect(engine.invoices.find_by_id(1).id).to eq(engine.invoices.all[0].id)
  end

  it 'can find by merchant id' do
    expect(engine.invoices.find_all_by_merchant_id(12335938).length).to eq 16
  end

  it 'can find by customer id' do
    expect(engine.invoices.find_all_by_customer_id(5).length).to eq 8
  end

  it 'can find by status' do
    expect(engine.invoices.find_all_by_status(:pending).length).to eq 1473
  end

  it 'can create a new invoice' do
    engine.invoices.create({
      :customer_id => 7,
      :merchant_id => 8,
      :status      => "pending",
    })

    expect(engine.invoices.all.last.id).to eq 4986
  end

  it 'can update an invoice' do
    engine.invoices.update(4985, {status: :shipped})

    expect(engine.invoices.all.last.status).to eq(:pending)
  end

  it 'can delete an invoice' do
    engine.invoices.delete(4986)

    expect(engine.invoices.find_by_id(4986)).to eq nil
  end
end