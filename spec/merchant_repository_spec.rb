require './lib/merchant_repository'

RSpec.describe MerchantRepository do

  before (:each) do
    @merchant1 = double('merchant')
    @merchant2 = double('merchant')
    @merchant3 = double('merchant')
    allow(@merchant1).to receive(:name){"NicKnacItems"}
    allow(@merchant2).to receive(:name){"NicksGoods"}
    allow(@merchant3).to receive(:name){"twosquaredblocks"}
    @mr = MerchantRepository.new([@merchant1, @merchant2, @merchant3])
  end

  it 'can list all merchants' do
    expect(@mr.all).to eq([@merchant1, @merchant2, @merchant3])
  end


  xit 'can find all merchants that include fragment' do
    expect(@mr.find_all_by_name("nick")).to eq([@merchant1,@merchant2])
  end

end
