require 'rspec'
require './lib/items'
require 'time'

RSpec.describe do
  se = SalesEngine.from_csv({
  :items     => "./data/items.csv",
  :merchants => "./data/merchants.csv",
  :invoices => "./data/invoices.csv"
  })
  ir = se.items

  context "Item" do
      it "can return id" do
        first_item = ir.all[0]
        expect(first_item.id).to eq(263395237)
        second_item = ir.all[1]
        expect(second_item.id).to eq(263395617)
      end

      it "can return name" do
        first_item = ir.all[0]
        expect(first_item.name).to eq("510+ RealPush Icon Set")
        second_item = ir.all[1]
        expect(second_item.name).to eq("Glitter scrabble frames")
      end

      it "can return description" do
        first_item = ir.all[0]
        expect(first_item.description.class).to eq(String)
        expect(first_item.description.length).to eq(2237)
      end

      it "can return unit price" do
        first_item = ir.all[0]
        expect(first_item.unit_price).to eq(12.00)
        expect(first_item.unit_price.class).to eq(BigDecimal)
      end

      # it "can return time created at" do
      #   first_item = ir.all[0]
      #   expected = Time.parse("2016-01-11 09:34:06 UTC")
      #   expect(first_item.created_at).to eq(expected)
      #   expect(first_item.created_at.class).to eq(Time)
      # end
      #
      # it "can return time updated at" do
      #   first_item = ir.all[0]
      #   expected = Time.parse("2007-06-04 21:35:10 UTC")
      #   expect(first_item.updated_at).to eq(expected)
      #   expect(first_item.updated_at.class).to eq(Time)
      # end

      it "unit_price_to_dollars returns unit price as a float" do
        first_item = ir.all[0]
        expect(first_item.unit_price_to_dollars).to eq(12.0)
        expect(first_item.unit_price_to_dollars.class).to eq(Float)
      end

    end
  end
