require_relative 'spec_helper'
require 'CSV'

RSpec.describe ItemRepository do
  describe 'instantiation' do
    it 'exists' do
      path = "fixture/item_fixture.csv"
      item_repo = ItemRepository.new(path)

      expect(item_repo).to be_a(ItemRepository)
    end

    it "returns array of all items" do
      path = "fixture/item_fixture.csv"
      item_repo = ItemRepository.new(path)

      expect(item_repo.all.length).to eq(4)
    end

    xit 'has readable attributes'
    path = "fixture/item_fixture.csv"
    item_repo = ItemRepository.new(path)

    expect(item_repo.all.first.id).to eq(263395617)
  end
end
