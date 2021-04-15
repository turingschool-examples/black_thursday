require 'rspec'
require './lib/items'

RSpec.describe do
  se = SalesEngine.from_csv({
  :items     => "./data/items.csv",
  :merchants => "./data/merchants.csv",
  })
  ir = se.items

  context "Item" do
      it "#id returns the id" do
        first_item = ir.all.first
        expect(first_item.id).to eq 263395237
        last_item = ir.all.last
        expect(last_item.id).to eq 263567474
      end

      it "#name returns the name" do
        first_item = ir.all.first
        expect(first_item.name).to eq "510+ RealPush Icon Set"
        last_item = ir.all.last
        expect(last_item.name).to eq "Minty Green Knit Crochet Infinity Scarf"
      end

      it "#description returns the description" do
        first_item = ir.all.first
        expect(first_item.description.class).to eq String
        expect(first_item.description.length).to eq 2237
      end

      it "#unit_price returns the unit price" do
        first_item = ir.all.first
        expect(first_item.unit_price).to eq 12.00
        expect(first_item.unit_price.class).to eq BigDecimal
      end

      it "#created_at returns the Time the item was created" do
        first_item = ir.all.first
        expect(first_item.created_at_to_time).to eq Time.parse("2016-01-11 09:34:06 UTC")
        expect(first_item.created_at_to_time.class).to eq Time
      end

      it "#updated_at returns the Time the item was last updated" do
        first_item = ir.all.first
        expect(first_item.updated_at_to_time).to eq Time.parse("2007-06-04 21:35:10 UTC")
        expect(first_item.updated_at_to_time.class).to eq Time
      end

      it "#unit_price_to_dollars returns price as Float" do
        expected = ir.find_by_id(263397059)
        expect(expected.unit_price_to_dollars).to eq 130.0
        expect(expected.unit_price_to_dollars.class).to eq Float
      end

    end
  end
