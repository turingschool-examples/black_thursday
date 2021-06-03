require 'rspec'
require './lib/merchant_repository'

describe MerchantRepository do
  
  it 'exists' do
    merchant_repository = double()
    allow(merchant_repository).to receive(:new) {true}
    expect(merchant_repository.new).to eq()
  end

  it 'has attributes' do
    merchant_repository = MerchantRepository.new(file_path.csv, engine)

    expect(merchant.file_path).to eq(file_path.csv)
    expect(merchant.engine).to eq(engine)
  end

  xit 'it can create a repo' do
    merchant_repository = MerchantRepository.new(file_path.csv, engine)


  end
end
