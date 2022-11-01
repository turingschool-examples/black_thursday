require './lib/general_repo'
require './lib/general'
require 'CSV'

RSpec.describe GeneralRepo do
  let(:data){ CSV.readlines('./data/general_test.csv', headers: true, header_converters: :symbol) }

  let(:gr) { GeneralRepo.new }

  let(:object1) { gr.create(data[0]) }
  let(:object2) { gr.create(data[1]) }
  let(:object3) { gr.create(data[2]) }
  let(:object4) { gr.create(data[3]) }
  let(:object5) { gr.create(data[4]) }

  describe '#initialize' do
    it 'exists and has readable attrs' do
      expect(gr).to be_a GeneralRepo
      expect(gr.repository).to eq [object1, object2, object3, object4, object5]
    end
  end

  describe '#all' do
    it 'returns a list of objects in its repository' do
      expect(gr.repository).to eq []
    end
  end

  describe '#find_by_id' do
    it 'finds one object in the repository with matching id' do
      expect(gr.find_by_id(3)).to eq object3
    end
  end

  describe '#create' do
    it 'takes in CSV data and makes an new object and stores it in the repo' do
      new_data = {attribute: 'fuscia'}
      new_object = gr.create(new_data)
      expect(new_object.attribute).to eq 'fuscia'
      expect(gr.repository).to eq [object1, object2, object3, object4, object5, new_object]
    end
  end

  describe '#update' do
    it 'can update an object(id) with attributes' do
      gr.update(3, {attribute: 'olive'})
      expect(gr.find_by_id(id).attribute).to eq 'olive'
    end
  end

  descirbe '#delete' do
    it 'can remove and object from its repository' do
      gr.delete(2)
      expect(gr.repository).to eq [object1, object3, object4, object5]
    end
  end
end