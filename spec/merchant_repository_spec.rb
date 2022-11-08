require './lib/requirements'

RSpec.describe MerchantRepository do
  let!(:mr) {MerchantRepository.new("./data/merchants.csv", nil)}
  # let!(:m_1) {Merchant.new({:id =>5, :name => "Turing School"})}
  # let!(:m_2) {Merchant.new({:id =>6, :name => "School of Hard Knocks"})}
  # let!(:m_3) {Merchant.new({:id =>7, :name => "School of Rock"})}

  it 'is an merchant repository class' do
    expect(mr).to be_a(MerchantRepository)
  end

  it 'returns all merchant instances' do
    expect(mr.all).to be_a Array
    expect(mr.all.length).to eq(475)
  end
  
  it 'can find merchant by an id' do
    expect(mr.find_by_id(12334112)).to eq(mr.all[1])
  end
  
  it 'returns nil if id is not within' do
    expect(mr.find_by_id(20)).to eq(nil)
    expect(mr.find_by_id("egg")).to eq(nil)
  end

  it 'can find merchant by name *CASE INSENSITIVE*' do
    expect(mr.find_by_name("jejum")).to eq(mr.all[7])
    expect(mr.find_by_name("jeJUM")).to eq(mr.all[7])
  end

  it 'returns nil if name is not within' do
    expect(mr.find_by_name("School of Music")).to eq(nil)
  end

  it 'can find ALL by supplied name fragment' do
    expect(mr.find_all_by_name('Etsy')).to eq([mr.all[152], mr.all[367]])
    expect(mr.find_all_by_name('eTSY')).to eq([mr.all[152], mr.all[367]])
    expect(mr.find_all_by_name('College')).to eq([])
  end

  it 'can create a new merchant object with attributes and the highest id + 1' do
    expect(mr.all.last.name).to eq("CJsDecor")
    expect(mr.all.last.id).to eq(12337411)
    
    mr.create({name: "Another Merchant"})
    
    expect(mr.all.last.name).to eq("Another Merchant")
    expect(mr.all.last.id).to eq(12337412)
  end

  it 'can update a merchant (by id) with new attributes *aka name updates*' do
    expect(mr.find_by_id(12337411).name).to eq("CJsDecor")
    
    mr.update(12337411, { name: "School of Light Knocks"})
    
    expect(mr.find_by_id(12337411).name).to eq("School of Light Knocks")
  end

  it 'can delete a merchant by supplied id' do
    expect(mr.all.length).to eq(475)
    
    mr.delete(12334112)

    expect(mr.all.length).to eq(474)
  end
end