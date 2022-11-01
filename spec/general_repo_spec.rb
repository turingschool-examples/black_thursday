require './lib/general_repo'

RSpec.describe GeneralRepo do
  let(:gr) { GeneralRepo.new }

  describe '#initialize' do
    it 'exists and has readable attrs' do
      expect(gr).to be_a GeneralRepo
      expect(gr.repository).to eq []
    end
  end

  describe '#all' do
    it 'returns a list of objects in its repository' do
      expect(gr.repository).to eq []
    end
  end

  describe '#find_by_id' do
    it 'finds one object in the repository with matching id' do
      expect(gr.find_by_id(id)).to eq OBJECT 
    end
  end

  describe '#create' do
    it 'takes in CSV data and makes an new object and stores it in the repo' do
      expect(gr.create(data)).to eq OOBJECT 
    end
  end

  describe '#update' do
    it 'can update an object(id) with attributes' do
      gr.update(id, attributes)
      expect(gr.find_by_id(id).attribute).to eq some_attribute
    end
  end

  descirbe '#delete' do
    it 'can remove and object from its repository' do
      gr.delete(id)
      expect(gr.repository).to eq not include id
    end
  end
end