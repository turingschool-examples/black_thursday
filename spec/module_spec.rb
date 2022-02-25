require './lib/module'
require './lib/merchant_repository'

RSpec.describe IDManager do
  before (:each) do
    @merchant1 = double("merchant", id: 1234, name: "pencil")
    @merchant2 = double("merchant", id: 1320, name: "eraser")
    @mr = MerchantRepository.new([@merchant1, @merchant2])
  end

  it 'can find units by id' do
    expect(@mr.find_by_id(1234)).to eq(@merchant1)
    expect(@mr.find_by_id(1320)).to eq(@merchant2)
    expect(@mr.find_by_id(1555)).to eq(nil)

  end

  it 'can find a unit by name' do
    expect(@mr.find_by_name("pencil")).to eq(@merchant1)
    expect(@mr.find_by_name("eraser")).to eq(@merchant2)
    expect(@mr.find_by_name("sock")).to eq(nil)
  end


  xit 'can create attributes' do
    mr.create(name: "book")
    expect(@mr.all.last.id).to eq(1321)

  end

  it 'can update an instance with a specific id' do
    expect(@merchant2).to receive(:merge).with(name: "chicken")
    @mr.update(1320, name: "chicken")
  end

  it 'can delete an id' do
    @mr.delete(1320)
    expect(@mr.all).to eq([@merchant1])
  end
end
