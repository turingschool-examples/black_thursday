require_relative 'spec_helper'

RSpec.describe MerchantRepository do

  before(:each) do
    @paths = {
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv"

    }
    @se = SalesEngine.from_csv(@paths)
  end

  it 'exists' do
    mr = @se.merchants

    expect(mr).to be_a(MerchantRepository)
  end

  it 'calls and reads correct file path' do
    mr = @se.merchants
    mr_csv_data = mr.all

    expect(mr_csv_data.class).to eq(Array)
    expect(mr_csv_data.length).to eq(475)

    data_validation = mr_csv_data.all? do |line|
      line.class == Merchant
    end

    expect(data_validation).to be(true)
  end

  it 'can find merchant by id' do
    mr = @se.merchants
    result = mr.find_by_id(mr.all[0].id)

    expect(result.name).to eq('Shopin1901')
  end

  it 'can find merchant by case insensitive name' do
    mr = @se.merchants
    result = mr.find_by_name(mr.all[0].name.upcase)

    expect(result.name).to eq('Shopin1901')
  end

  it 'can find all by name' do
    mr = @se.merchants
    result = mr.find_all_by_name('by'.upcase)

    expect(result.class).to eq(Array)
    expect(result.length).to eq(24)
  end

  it 'can create new instance with attributes' do
    mr = @se.merchants
    new_merchant = {:id => mr.create_new_id, :name => 'Turing School'}
    mr.create(new_merchant)
    result = mr.all[-1]

    expect(result.class).to eq(Merchant)
    expect(result.id).to eq(12337412)
    expect(result.name).to eq('Turing School')
  end

  it 'can update an existing Merchant instance name' do
    mr = @se.merchants
    merchant_update = {:name => 'Cohort2105'}

    mr.update(mr.all[0].id, merchant_update)
    result = mr.all[-1]

    expect(result.name).to eq(merchant_update[:name])
  end

  it 'can delete an existing Merchant instance' do
    mr = @se.merchants

    old_length = mr.all.length

    mr.delete(mr.all[0].id)
    new_length = mr.all.length

    expect(old_length - new_length).to eq(1)
  end
end
