require_relative 'spec_helper'

RSpec.describe MerchantRepository do
  it "exists" do
    se = SalesEngine.new
    mr = MerchantRepository.new(se.library[:merchants])

    expect(mr).to be_a(MerchantRepository)
  end

  it "calls and reads correct file path" do
    se = SalesEngine.new
    mr = MerchantRepository.new(se.library[:merchants])
    mr_csv_data = mr.all

    expect(mr_csv_data.class).to eq(Array)
    expect(mr_csv_data.length).to eq(475)
    # require 'pry'; binding.pry
    data_validation = mr_csv_data.all? do |line|
      line.class == Hash
      line.keys.length == 4
      line.values.length == 4
    end

    expect(data_validation).to be(true)
  end

  it 'can find merchant by id' do
    se = SalesEngine.new
    mr = MerchantRepository.new(se.library[:merchants])
    result = mr.find_by_id(mr.all[0]['id'])

    expect(result['name']).to eq('Shopin1901')
  end

  it 'can find merchant by case insensitive name' do
    se = SalesEngine.new
    mr = MerchantRepository.new(se.library[:merchants])
    result = mr.find_by_name(mr.all[0]['name'].upcase)

    expect(result['name']).to eq('Shopin1901')
  end

  it 'can find all by name' do
    se = SalesEngine.new
    mr = MerchantRepository.new(se.library[:merchants])
    result = mr.find_all_by_name('by'.upcase)

    expect(result.length).to eq(24)
  end

end
