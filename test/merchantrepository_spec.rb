require 'rspec'
require 'csv'
require './lib/merchant'
require './lib/merchantrepository'
require './lib/sales_engine'

RSpec.describe 'MerchantRepository' do

  it "can find a merchant by ID number" do
    se = SalesEngine.new({ :items      => "./data/items.csv",
                       :merchants      => "./data/merchants.csv",
                       :invoices       => './data/invoices.csv',
                       :invoice_items  => './data/invoice_items.csv',
                       :transactions   => './data/transactions.csv',
                       :customers      => './data/customers.csv'})
    mr = se.merchants

    expect(mr).to be_a(MerchantRepository)
    expect(mr.find_by_id(12334146).id).to eq(12334146)
    expect(mr.find_by_id(12334146).name).to eq("MotankiDarena")
  end

  it 'can find a merchant by name' do

    se = SalesEngine.new({ :items      => "./data/items.csv",
                       :merchants      => "./data/merchants.csv",
                       :invoices       => './data/invoices.csv',
                       :invoice_items  => './data/invoice_items.csv',
                       :transactions   => './data/transactions.csv',
                       :customers      => './data/customers.csv'})
    mr = se.merchants

    expect(mr.find_by_name("Shopin1901").name).to eq("Shopin1901")
    expect(mr.find_by_name("FANCYBOOKART").name).to eq("fancybookart")
  end

  it 'finds all by name' do
    se = SalesEngine.new({ :items      => "./data/items.csv",
                       :merchants      => "./data/merchants.csv",
                       :invoices       => './data/invoices.csv',
                       :invoice_items  => './data/invoice_items.csv',
                       :transactions   => './data/transactions.csv',
                       :customers      => './data/customers.csv'})
    mr = se.merchants

    expect(mr.find_all_by_name("Georgia").first.name).to eq("GeorgiaFayeDesigns")
    expect(mr.find_all_by_name("shop")[2].name).to eq("Woodenpenshop")
  end

  it 'creates' do
    se = SalesEngine.new({ :items      => "./data/items.csv",
                       :merchants      => "./data/merchants.csv",
                       :invoices       => './data/invoices.csv',
                       :invoice_items  => './data/invoice_items.csv',
                       :transactions   => './data/transactions.csv',
                       :customers      => './data/customers.csv'})
    mr = se.merchants

    attributes = {
                  :id    => 12337412,
                  :name  => "Turing School of Software and Design"
                }

    expect(mr.all.length).to eq(475)
    mr.create(attributes)
    expect(mr.all.length).to eq(476)
  end

  it "can update the name of merchants" do
    se = SalesEngine.new({ :items      => "./data/items.csv",
                       :merchants      => "./data/merchants.csv",
                       :invoices       => './data/invoices.csv',
                       :invoice_items  => './data/invoice_items.csv',
                       :transactions   => './data/transactions.csv',
                       :customers      => './data/customers.csv'})
    mr = se.merchants

    attributes = {
                  :name => "Bluebow",
                  :updated_at => Time.now
                  }

    mr.update(12334149, attributes)
    expect(mr.find_by_id(12334149).name).to eq("Bluebow")

  end

  it "can delete merchants" do
    se = SalesEngine.new({ :items      => "./data/items.csv",
                       :merchants      => "./data/merchants.csv",
                       :invoices       => './data/invoices.csv',
                       :invoice_items  => './data/invoice_items.csv',
                       :transactions   => './data/transactions.csv',
                       :customers      => './data/customers.csv'})
    mr = se.merchants

    mr.delete(12337413)

    expect(mr.find_by_id(12337413)).to eq(nil)
  end
end
