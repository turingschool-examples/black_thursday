require 'simplecov'
SimpleCov.start
require 'rspec'
require './lib/item'


RSpec.describe Item do
  it "exists" do
    repo_double = double("item_repo")
    item = Item.new({
      id: "263399735",
      name:  "Bootees",
      description: "Gorgeous hand knitted baby bootees",
      unit_price: "1200",
      merchant_id: "12334271",
      created_at: "2016-01-11 11:34:30 UTC",
      updated_at: "1999-03-24 02:37:51 UTC"
      }, repo_double)

      expect(item).to be_a(Item)
    end

    it "has attributes" do
      repo_double = double("item_repo")
      item = Item.new({
        id: "263399735",
        name:  "Bootees",
        description: "Gorgeous hand knitted baby bootees",
        unit_price: "1200",
        merchant_id: "12334271",
        created_at: "2016-01-11 11:34:30 UTC",
        updated_at: "1999-03-24 02:37:51 UTC"
        }, repo_double)

        expect(item.id).to eq(263399735)
        expect(item.name).to eq("Bootees")
        expect(item.description).to eq("Gorgeous hand knitted baby bootees")
        expect(item.unit_price).to eq( 0.12e2)
        expect(item.merchant_id).to eq(12334271)
        expect(item.created_at).to eq Time.parse("2016-01-11 11:34:30 UTC")
        expect(item.updated_at).to eq Time.parse("1999-03-24 02:37:51 UTC")
      end

      it "can change unit price to dollars" do
        repo_double = double("item_repo")
        item = Item.new({
          id: "263399735",
          name:  "Bootees",
          description: "Gorgeous hand knitted baby bootees",
          unit_price: "1200",
          merchant_id: "12334271",
          created_at: "2016-01-11 11:34:30 UTC",
          updated_at: "1999-03-24 02:37:51 UTC"
          }, repo_double)

          expect(item.unit_price_to_dollars).to eq(12.0)
      end

      it "can change unit price to dollars" do
        repo_double = double("item_repo")
        item = Item.new({
          id: "263399735",
          name:  "Bootees",
          description: "Gorgeous hand knitted baby bootees",
          unit_price: "1200",
          merchant_id: "12334271",
          created_at: "2016-01-11 11:34:30 UTC",
          updated_at: "1999-03-24 02:37:51 UTC"
          }, repo_double)

          item.change_unit_price(5)

          expect(item.unit_price).to eq(5)
      end

      it "can update time" do
        repo_double = double("item_repo")
        item = Item.new({
          id: "263399735",
          name:  "Bootees",
          description: "Gorgeous hand knitted baby bootees",
          unit_price: "1200",
          merchant_id: "12334271",
          created_at: "2016-01-11 11:34:30 UTC",
          updated_at: "1999-03-24 02:37:51 UTC"
          }, repo_double)

          item.update_time

          expect(item.updated_at.to_i).to eq(Time.now.to_i)
      end
end
