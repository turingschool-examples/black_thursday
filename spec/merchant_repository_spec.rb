require './lib/merchant'
require './lib/merchant_repository'

RSpec.describe MerchantRepository do
  let(:merch_repo) {MerchantRepository.new}

  it 'exists' do
    expect(merch_repo).to be_a(MerchantRepository)
  end

  it '#initialize stores merchants, empty by default' do
    expect(merch_repo.repo).to eq([])
  end

  it '#create makes new Merchants, id + 1' do
    merchant1 = merch_repo.create({ id: 1, name: 'Turing School' })
    merchant2 = merch_repo.create({ name: 'Another School' })

    expect(merchant1).to be_a(Merchant)
    expect(merchant1.id).to eq(1)
    expect(merchant2.id).to eq(2)
  end

  it '#all lists all Merchants' do
    merchant1 = merch_repo.create({ id: 5, name: 'Turing School' })
    merchant2 = merch_repo.create({ id: 6, name: 'Another School' })
    merchant3 = merch_repo.create({ id: 7, name: 'The Other School' })
    expect(merch_repo.all).to eq([merchant1, merchant2, merchant3])
  end

  it '#find_by_id' do
    merchant1 = merch_repo.create({ id: 5, name: 'Turing School' })

    expect(merch_repo.find_by_id(5)).to eq(merchant1)
    expect(merch_repo.find_by_id(8)).to be(NIL)
  end

  it '#find_by_name' do
    merchant1 = merch_repo.create({ id: 5, name: 'Turing School' })

    expect(merch_repo.find_by_name('turing school')).to eq(merchant1)
    expect(merch_repo.find_by_name("Bobby's World")).to be(NIL)
  end

  it '#find_all_by_name' do
    merchant1 = merch_repo.create({ id: 5, name: 'Turing School' })
    merchant2 = merch_repo.create({ id: 6, name: 'Another School' })
    merchant3 = merch_repo.create({ id: 7, name: 'The Other School' })

    expect(merch_repo.find_all_by_name('school')).to eq([merchant1, merchant2, merchant3])
    expect(merch_repo.find_all_by_name("Bobby's World")).to eq([])
  end

  it '#delete Merchants by id' do

    merchant1 = merch_repo.create({ id: 5, name: 'Turing School' })
    merchant2 = merch_repo.create({ id: 6, name: 'Another School' })
    merchant3 = merch_repo.create({ id: 7, name: 'The Other School' })

    expect(merch_repo.all).to eq([merchant1, merchant2, merchant3])

    merch_repo.delete(6)
    expect(merch_repo.all).to eq([merchant1, merchant3])
  end

  it '#update merchant name' do
    merchant1 = merch_repo.create({ id: 5, name: 'Turing School' })
    expect(merchant1.name).to eq('Turing School')

    merch_repo.update(5, { name: 'Different School' })
    expect(merchant1.name).to eq('Different School')
  end

#   it '#parse reads csv data' do
#   merch_repo.parse_data({merchants: './data/merchants.csv'})
#   mocks and stubs
#   end
end