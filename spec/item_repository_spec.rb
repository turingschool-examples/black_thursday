require_relative 'spec_helper'

RSpec.describe ItemRepository do
  it "exists" do
    se = SalesEngine.new
    ir = ItemRepository.new(se.library[:items])

    expect(ir).to be_a(ItemRepository)
  end

  it "calls and reads correct file path" do
    se = SalesEngine.new
    ir = ItemRepository.new(se.library[:items])
    ir_csv_data = ir.read_csv

    expect(ir_csv_data.class).to eq(Array)
    expect(ir_csv_data.length).to eq(1367)

    data_validation = ir_csv_data.all? do |line|
      line.class == Hash
      line.keys.length == 7
      line.values.length == 7
    end

    expect(data_validation).to be(true)
  end
end
