require 'SimpleCov'
SimpleCov.start

require_relative '../lib/invoice_repository'
require_relative '../lib/invoice'

RSpec.describe InvoiceRepository do
  before :each do
    @ir = InvoiceRepository.new('./spec/fixture_files/invoice_fixture.csv')
  end

  it 'exists' do
    expect(@ir).to be_an_instance_of(InvoiceRepository)
  end

  it 'can create invoice objects' do
    expect(@ir.all.length).to eq(5)
    expect(@ir.all[0]).to be_an_instance_of(Invoice)
  end

  it 'can find invoice by ID' do
    expect(@ir.find_by_id(1)).to eq(@ir.all[0])
    expect(@ir.find_by_id(2)).to eq(@ir.all[1])
  end

  it 'finds all invoices by customer_id' do
    expect(@ir.find_all_by_customer_id(1)).to eq([@ir.all[0], @ir.all[1]])
    expect(@ir.find_all_by_customer_id(2)).to eq([@ir.all[2]])
    expect(@ir.find_all_by_customer_id(4)).to eq([])
  end

  it 'finds all invoices by merchant_id' do
    expect(@ir.find_all_by_merchant_id(5)).to eq([@ir.all[0], @ir.all[2]])
    expect(@ir.find_all_by_merchant_id(6)).to eq([@ir.all[1]])
    expect(@ir.find_all_by_merchant_id(8)).to eq([])
  end

  it 'finds all invoices by status' do
    expect(@ir.find_all_by_status('pending')).to eq([@ir.all[0], @ir.all[3], @ir.all[4]])
    expect(@ir.find_all_by_status('shipped')).to eq([@ir.all[1], @ir.all[2]])
    expect(@ir.find_all_by_status('returned')).to eq([])
  end

  it 'finds all invoices by date' do
    expect(@ir.find_all_by_date(Time.parse('2021-05-28'))).to eq([@ir.all[2]])
  end

  it 'creates a new instance with attributes' do
    expected = @ir.create({
                            :customer_id => 3,
                            :merchant_id => 5,
                            :status      => 'pending',
                            :created_at  => Time.now.to_s,
                            :updated_at  => Time.now.to_s,
                         })

    expect(@ir.all.length).to eq(6)
    expect(expected.id).to eq(6)
  end


  it 'finds invoice by ID and updates attributes' do
    data = {
              :status => 'shipped',
              :updated_at  => Time.now.to_s,
           }
    @ir.update(1, data)
    expected = @ir.find_by_id(1)

    expect(expected.customer_id).to eq(1)
    expect(expected.merchant_id).to eq(5)
    expect(expected.status).to eq('shipped')
  end

  it 'finds and deletes invoice by ID' do
    @ir.delete(2)

    expect(@ir.all.length).to eq(4)
  end
end
