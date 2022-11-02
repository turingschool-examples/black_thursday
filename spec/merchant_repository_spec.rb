require './lib/merchant_repository'

RSpec.describe MerchantRepository do
  it 'exists' do
    mr = MerchantRepository.new

    expect(mr).to be_a(MerchantRepository)
  end

  it 'can have merchants' do
    mr = MerchantRepository.new
    m = {id: 5, name: "Turing School"}
    mr.add(m)

    expect(mr.merchants[0].name).to eq(m[:name])
  end

  it 'can list an array of all merchants' do
    mr = MerchantRepository.new
    m = {id: 5, name: "Turing School"}
    m2 = {id: 4, name: "Porsche"}
    mr.add(m)
    mr.add(m2)

    expect(mr.all).to be_a Array
  end

  it 'can find a specific merchant by id' do
    mr = MerchantRepository.new
    m = {id: 5, name: "Turing School"}
    m2 = {id: 4, name: "Porsche"}
    mr.add(m)
    mr.add(m2)

    expect(mr.find_by_id(4).id).to eq(m2[:id])
  end

  it 'can find a specific merchant by name' do
    mr = MerchantRepository.new
    m = {id: 5, name: "Turing School"}
    m2 = {id: 4, name: "Porsche"}
    mr.add(m)
    mr.add(m2)

    expect(mr.find_by_name("porsche").name).to eq(m2[:name])
  end

  it 'can find a all merchants that have the input as part of their name' do
    mr = MerchantRepository.new
    m = {id: 5, name: "Turing School"}
    m2 = {id: 4, name: "Porsche"}
    m3 = {id: 3, name: "Porsche AG"}
    mr.add(m)
    mr.add(m2)
    mr.add(m3)

    expect(mr.find_all_by_name("porsche")[0].name).to eq(m2[:name])
    expect(mr.find_all_by_name("porsche")[1].name).to eq(m3[:name])
  end

  it 'can create a new merchant' do
    mr = MerchantRepository.new
    m = {id: 5, name: "Turing School"}
    m2 = {id: 4, name: "Porsche"}
    m3 = {id: 3, name: "Porsche AG"}
    mr.add(m)
    mr.add(m2)
    mr.add(m3)
    mr.create("BMW AG")

    expect(mr.merchants.last.name).to eq("BMW AG")
  end

  it 'can create a new merchant' do
    mr = MerchantRepository.new
    m = {id: 5, name: "Turing School"}
    m2 = {id: 4, name: "Porsche"}
    m3 = {id: 3, name: "Porsche AG"}
    mr.add(m)
    mr.add(m2)
    mr.add(m3)
    mr.update(5, "Turing School of Software and Design")

    expect(mr.merchants.first.name).to eq("Turing School of Software and Design")
  end

  it 'can delete a merchant' do
    mr = MerchantRepository.new
    m = {id: 5, name: "Turing School"}
    m2 = {id: 4, name: "Porsche"}
    m3 = {id: 3, name: "Porsche AG"}
    mr.add(m)
    mr.add(m2)
    mr.add(m3)
    mr.delete(4)

    expect(mr.find_by_id(4)).to eq(nil)
  end
end
