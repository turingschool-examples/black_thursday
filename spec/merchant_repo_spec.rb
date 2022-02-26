require "./lib/merchant_repo"
require "./lib/sales_engine"
require "./lib/merchant"
require "pry"

RSpec.describe MerchantRepository do
  let(:se) do
    SalesEngine.from_csv({
      items: "./data/items.csv",
      merchants: "./data/merchants.csv"
    })
  end

  let(:mr) do
    MerchantRepository.new(se.merchants_instanciator)
  end

  it "is an instance of MerchantRepository" do
    expect(mr).to be_an_instance_of(MerchantRepository)
  end

  it "returns an array of all merchant instances" do
    expect(mr.all.count).to eq 475
  end

  it "finds a merchant by id" do
    expected_merchant = mr.find_by_id(12335677)
    expect(expected_merchant.merchant_attributes[:id]).to eq 12335677
    expect(expected_merchant.merchant_attributes[:name]).to eq "filiy"
  end

  it "#find_by_id returns nil if merchant does not exist" do
    expect(mr.find_by_id(99999999)).to eq(nil)
  end

  it "finds a merchant by name" do
    expected_merchant = mr.find_by_name("shop20161")
    expect(expected_merchant.merchant_attributes[:id]).to eq(12335213)
    expect(expected_merchant.merchant_attributes[:name]).to eq("shop20161")
  end

  it "#find_by_name is case insensitive" do
    expected_merchant = mr.find_by_name("SEWCWTCH")
    expected_merchant2 = mr.find_by_name("dejavuelry")
    expect(expected_merchant.merchant_attributes[:id]).to eq(12335009)
    expect(expected_merchant2.merchant_attributes[:id]).to eq(12335716)
  end

  it "#find_by_name returns nil if merchant does not exist" do
    expected_merchant = mr.find_by_name("Bob's Crab Shack")
    expect(expected_merchant).to eq nil
  end

  it "finds all merchants by name fragment" do
    expected_merchant = mr.find_all_by_name("store")
    expect(expected_merchant.length).to eq(4)
  end

  it "#find_all_by_name returns empty array if no matches" do
    expected_merchant = mr.find_all_by_name("Bob's Crab")
    expect(expected_merchant).to eq([])
  end

  it "creates a new merchant instance" do
    attributes = {name: "Bob's Crab Shack"}
    mr.create(attributes)
    expected_merchant = mr.find_by_name("Bob's Crab Shack")
    # expected_merchant = mr.find_by_id(12337412)
    expect(expected_merchant.merchant_attributes[:name]).to eq("bob's crab shack")
  end
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
