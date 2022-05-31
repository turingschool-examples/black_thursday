require './lib/item'

RSpec.describe Item do
  before :each do
    @pencil = Item.new({
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 2
    })
  end

  describe "#initialize" do
    it "is an Item" do
      expect(@item).to be_a Item
    end

    it "has an ID" do
      expect(@item.id).to eq 1
    end

    it "has a name" do
      expect(@item.name).to eq "Pencil"
    end

    it "has a description" do
      expect(@item.description).to eq "You can use it to write things"
    end

    it "has a unit price" do
      expect(@item.unit_price).to eq BigDecimal(10.99,4)
    end

    it "has a created time" do
      expect(@item.created_at).to eq Time.now
    end

    it "has an updated time" do
      expect(@item.updated_at).to eq Time.now
    end

    it "has a merchant ID" do
      expect(@item.merchant_id).to eq 2
    end
  end

  describe "#unit_price_to_dollars" do
    xit "returns a unit price as a float" do
      #some stuff here, an
    end
  end
end
