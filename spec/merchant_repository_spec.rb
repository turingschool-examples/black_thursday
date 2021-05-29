require_relative './spec_helper'

RSpec.describe MerchantRepository do

  it "exists" do

    se = SalesEngine.new
    mr = MerchantRepository.new(se.library[:merchants])

    expect(mr).to be_a(MerchantRepository)
  end

  it "calls and reads correct file path" do

    se = SalesEngine.new
    mr = MerchantRepository.new(se.library[:merchants])

    expect(mr.read_csv.class).to eq(Array)
    expect(mr.read_csv.length).to eq(475)

    data_validation = mr.read_csv.all? do |line|
      line.class == Hash
      line.keys.length == 4
      line.values.length == 4
    end

    expect(data_validation).to be(true)
  end
end
