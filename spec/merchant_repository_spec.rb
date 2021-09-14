require './lib/merchant_repository'


RSpec.describe MerchantRepository do
  it "exists" do
  mr = MerchantRepository.new

  expect(mr).to be_an_instance_of(MerchantRepository)
  end

  it 'can return an array of all known merchants' do
  mr = MerchantRepository.new

  expect(mr.all).to be_an(Array)
  end
end
