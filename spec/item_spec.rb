require_relative 'item'
require 'BigDecimal'

RSpec.describe Item do
  before :each do
    @pencil = Item.new({
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => 1099,
      :created_at  => '1994-05-07 23:38:43 UTC',
      :updated_at  => '2016-01-11 11:30:35 UTC',
      :merchant_id => 2
    })
  end

  describe "#initialize" do
    it "is an Item" do
      expect(@pencil).to be_a Item
    end

    it "has an ID" do
      expect(@pencil.id).to eq 1
    end

    it "has a name" do
      expect(@pencil.name).to eq "Pencil"
    end

    it "has a description" do
      expect(@pencil.description).to eq "You can use it to write things"
    end

    it "has a unit price" do
      expect(@pencil.unit_price).to eq 0.1099e2
    end

    it "has a created time" do
      expect(@pencil.created_at).to eq '1994-05-07 23:38:43 UTC'
    end

    it "has an updated time" do
      expect(@pencil.updated_at).to eq '2016-01-11 11:30:35 UTC'
    end

    it "has a merchant ID" do
      expect(@pencil.merchant_id).to eq 2
    end
  end

  describe "#unit_price_to_dollars" do
    it "returns a unit price as a float" do
      expect(@pencil.unit_price_to_dollars).to eq 10.99
    end
  end
end
