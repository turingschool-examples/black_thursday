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
    require 'pry'; binding.pry
    data_validation = mr_csv_data.all? do |line|
      line.class == Hash
      line.keys.length == 4
      line.values.length == 4
    end

    expect(data_validation).to be(true)
  end
end
