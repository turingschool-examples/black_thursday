# require_relative './spec_helper'
#
# RSpec.describe ItemRepository do
#
#   it "exists" do
#
#     se = SalesEngine.new
#     ir = ItemRepository.new(se.library[:items])
#
#     expect(ir).to be_a(ItemRepository)
#   end
#
#   it "calls and reads correct file path" do
#
#     se = SalesEngine.new
#     ir = ItemRepository.new(se.library[:items])
#
#     expect(ir.read_csv.class).to eq(Array)
#     expect(ir.read_csv.length).to eq(475)
#
#     data_validation = ir.read_csv.all? do |line|
#       line.class == Hash
#       line.keys.length == 4
#       line.values.length == 4
#     end
#
#     expect(data_validation).to be(true)
#   end
# end
