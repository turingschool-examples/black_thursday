require_relative 'spec_helper'
require 'CSV'

RSpec.describe ItemRepository do
  describe 'instantiation' do
    it 'exists' do
      path = "fixture/item_fixture.csv"
      item_repo = ItemRepository.new(path)

      expect(item_repo).to be_a(ItemRepository)
    end

    it "returns array of all items and has readable attributes" do
      path = "fixture/item_fixture.csv"
      item_repo = ItemRepository.new(path)
      all = item_repo.all
      expect(all.length).to eq(4)
      expect(all.first.id).to eq(263395617)
      expect(all.first.name).to eq("Glitter scrabble frames")
      expect(all.first.description).to be_a(String)
      expect(all.first.unit_price).to eq(1300)
      expect(all.first.created_at).to be_a(String)
      expect(all.first.updated_at).to be_a(String)
      expect(all.first.merchant_id).to eq(12334185)
    end
  end
end
