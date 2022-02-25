require "./lib/merchant_repo"
require "./lib/sales_engine"
require "./lib/merchant"
require "pry"

RSpec.describe MerchantRepository do
  se = SalesEngine.from_csv({
    items: "./data/items.csv",
    merchants: "./data/merchants.csv"
  })
  mr = MerchantRepository.new(se.merchants_instanciator)

  it "is an instance of MerchantRepository" do
    expect(mr).to be_an_instance_of(MerchantRepository)
  end

  it "can return an array of all merchant instances" do
    expect(mr.all.count).to eq 475
  end

  it "can find a merchant by id" do
    test_id = 12335677
    expected_merchant = mr.find_by_id(test_id)
    expect(expected_merchant.id).to eq 12335677
    expect(expected_merchant.name).to eq "Filiy"
  end
  #
  #   it "#find_by_id returns nil if the merchant does not exist" do
  #     id = 101
  #     expected = engine.merchants.find_by_id(id)
  #
  #     expect(expected).to eq nil
  #   end
  #
  #   it "#find_by_name finds the first matching merchant by name" do
  #     name = "leaburrot"
  #     expected = engine.merchants.find_by_name(name)
  #
  #     expect(expected.id).to eq 12334411
  #     expect(expected.name).to eq name
  #   end
  #
  #   it "#find_by_name is a case insensitive search" do
  #     name = "LEABURROT"
  #     expected = engine.merchants.find_by_name(name)
  #
  #     expect(expected.id).to eq 12334411
  #
  #     name = "leaburrot"
  #     expected = engine.merchants.find_by_name(name)
  #
  #     expect(expected.id).to eq 12334411
  #   end
  #
  #   it "#find_by_name returns nil if the merchant does not exist" do
  #     name = "Turing School of Software and Design"
  #     expected = engine.merchants.find_by_name(name)
  #
  #     expect(expected).to eq nil
  #   end
  #
  #   it "#find_all_by_name finds all merchants matching the given name fragment" do
  #     fragment = "style"
  #     expected = engine.merchants.find_all_by_name(fragment)
  #
  #     expect(expected.length).to eq 3
  #     expect(expected.map(&:name).include?("justMstyle")).to eq true
  #     expect(expected.map(&:id).include?(12337211)).to eq true
  #   end
  #
  #   it "#find_all_by_name returns an empty array if there are no matches" do
  #     name = "Turing School of Software and Design"
  #     expected = engine.merchants.find_all_by_name(name)
  #
  #     expect(expected).to eq []
  #   end
  #
  #   it "#create creates a new merchant instance" do
  #     attributes = {
  #       name: "Turing School of Software and Design"
  #     }
  #     engine.merchants.create(attributes)
  #     expected = engine.merchants.find_by_id(12337412)
  #     expect(expected.name).to eq "Turing School of Software and Design"
  #   end
  #
  #   it "#update updates a merchant" do
  #     attributes = {
  #       name: "TSSD"
  #     }
  #     engine.merchants.update(12337412, attributes)
  #     expected = engine.merchants.find_by_id(12337412)
  #     expect(expected.name).to eq "TSSD"
  #     expected = engine.merchants.find_by_name("Turing School of Software and Design")
  #     expect(expected).to eq nil
  #   end
  #
  #   it "#update cannot update id" do
  #     attributes = {
  #       id: 13000000
  #     }
  #     engine.merchants.update(12337412, attributes)
  #     expected = engine.merchants.find_by_id(13000000)
  #     expect(expected).to eq nil
  #   end
  #
  #   it "#update on unknown merchant does nothing" do
  #     engine.merchants.update(13000000, {})
  #   end
  #
  #   it "#delete deletes the specified merchant" do
  #     engine.merchants.delete(12337412)
  #     expected = engine.merchants.find_by_id(12337412)
  #     expect(expected).to eq nil
  #   end
  #
  #   it "#delete on unknown merchant does nothing" do
  #     engine.merchants.delete(12337412)
  #   end
  # end
  #
  # context "Merchant" do
  #   it "#id returns the merchant id" do
  #     merchant = engine.merchants.all.first
  #     expect(merchant.id).to eq 12334105
  #   end
  #
  #   it "#name returns the merchant name" do
  #     merchant_one = engine.merchants.all.first
  #     expect(merchant_one.name).to eq "Shopin1901"
  #
  #     merchant_two = engine.merchants.all.last
  #     expect(merchant_two.name).to eq "CJsDecor"
  #   end
end
