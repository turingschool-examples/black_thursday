require_relative '../lib/invoice_repository'

RSpec.describe InvoiceRepository do
  it 'exists and has no invoices by default' do
    invr = InvoiceRepository.new

    expect(invr).to be_a(InvoiceRepository)
    expect(invr.invoices).to eq([])
  end

  it 'can find all' do
    se = SalesEngine.from_csv({:invoices => "./data/invoices.csv"})

    expect(se.invoices.all.first).to be_a Invoice
    expect(se.invoices.all).to be_a Array
  end

  it 'can find by id' do
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv"
      })

    expect(se.invoices.find_by_id(1).id).to eq(se.invoices.all[0].id)
  end

  it 'can find by merchant id' do
    se = SalesEngine.from_csv({:invoices => "./data/invoices.csv"})

    expect(se.invoices.find_all_by_merchant_id(12335938).length).to eq 16
  end

  it 'can find by customer id' do
    se = SalesEngine.from_csv({:invoices => "./data/invoices.csv"})

    expect(se.invoices.find_all_by_customer_id(5).length).to eq 8
  end

  it 'can find by status' do
    se = SalesEngine.from_csv({:invoices => "./data/invoices.csv"})

    expect(se.invoices.find_all_by_status(:pending).length).to eq 1473
  end

  it 'can create a new invoice' do
    se = SalesEngine.from_csv({:invoices => "./data/invoices.csv"})
    se.invoices.create({
      :customer_id => 7,
      :merchant_id => 8,
      :status      => "pending",
    })

    expect(se.invoices.all.last.id).to eq 4986
  end

  it 'can update an invoice' do
    se = SalesEngine.from_csv({:invoices => "./data/invoices.csv"})
    se.invoices.create({
      :customer_id => 7,
      :merchant_id => 8,
      :status      => "pending",
    })

    se.invoices.update(4986, {status: :shipped})

    expect(se.invoices.all.last.status).to eq(:shipped)
  end

  it 'can delete an invoice' do
    se = SalesEngine.from_csv({:invoices => "./data/invoices.csv"})
    se.invoices.delete(4823)

    expect(se.invoices.find_by_id(4823)).to eq nil
  end
end