require './lib/merchant'
require './lib/merchantrepository'

RSpec.describe MerchantRepository do
  let!(:mr) {MerchantRepository.new([m_1, m_2, m_3])}
  let!(:m_1) {Merchant.new({:id =>5, :name => "Turing School"})}
  let!(:m_2) {Merchant.new({:id =>6, :name => "School of Hard Knocks"})}
  let!(:m_3) {Merchant.new({:id =>7, :name => "School of Rock"})}

  it 'is an merchant repository class' do
    expect(mr).to be_a(MerchantRepository)
  end

  it 'returns all merchant instances' do
    expect(mr.all).to eq([m_1, m_2, m_3])
  end
  
  it 'can find merchant by an id' do
    expect(mr.find_by_id(5)).to eq(m_1)
  end
  
  it 'returns nil if id is not within' do
    expect(mr.find_by_id(20)).to eq(nil)
  end

  it 'can find merchant by name *CASE INSENSITIVE*' do
    expect(mr.find_by_name("School of Rock")).to eq(m_3)
  end

  it 'returns nil if name is not within' do
    expect(mr.find_by_name("School of Music")).to eq(nil)
  end

  it 'can find ALL by supplied name fragment' do
    expect(mr.find_all_by_name('of')).to eq([m_2, m_3])
    expect(mr.find_all_by_name('College')).to eq([])
  end

  xit 'can create a new merchant object with attributes' do
    expect(mr.create(m_4)).to eq(m_4)
  end

  xit 'gives the new merchant object the highest id + 1' do
    expect(mr.create(m_4).id).to eq(8)
  end

  it 'can update a merchant (by id) with new attributes *aka name updates*' do
    # use id to reference object, change attributes
    expect(mr.update(6, "School of Light Knocks")).to eq(m_2.name)
  end

  it 'can delete a merchant by supplied id' do
    mr.delete(5)
    expect(mr.delete(5)).to eq(mr.all)
  end
  

end