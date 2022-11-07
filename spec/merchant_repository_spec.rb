require_relative '../lib/merchant_repository'
require "spec_helper_2"

RSpec.describe MerchantRepository do
  it 'exists' do
    expect(engine.merchants).to be_a(MerchantRepository)
  end

  it 'can have merchants' do
    expect(engine.merchants.all[0].name).to eq('Shopin1901')
  end

  it 'can list an array of all merchants' do
    expect(engine.merchants.all).to be_a Array
  end

  it 'can find a specific merchant by id' do
    expect(engine.merchants.find_by_id(12334105).name).to eq('Shopin1901')
  end

  it 'can find a specific merchant by name' do
    expect(engine.merchants.find_by_name('Shopin1901').id).to eq 12334105
  end

  it 'can find a all merchants that have the input as part of their name' do
    expect(engine.merchants.find_all_by_name('shop').length).to eq 26
    expect(engine.merchants.find_all_by_name('shop')[0].name).to eq('Shopin1901')
  end

  it 'can create a new merchant' do
    engine.merchants.create({name: "BMW AG"})

    expect(engine.merchants.all.last.name).to eq("BMW AG")
  end

  it 'can update a merchant' do
    engine.merchants.update(12334105, {name: "Turing School of Software and Design"})

    expect(engine.merchants.find_by_id(12334105).name).to eq("Turing School of Software and Design")
  end

  it 'can delete a merchant' do
    engine.merchants.delete(12337412)

    expect(engine.merchants.find_by_id(12337412)).to eq nil
  end
end
