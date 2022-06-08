require './lib/customer_repository'

RSpec.describe CustomerRepository do
  before :each do
    @filepath = './data/customers.csv'
    @collection = CustomerRepository.new(@filepath)
    @attributes = {
      :id => 6,
      :first_name => "Joan",
      :last_name => "Clarke",
      :created_at  => Time.parse('1994-05-07 23:38:43 UTC'),
      :updated_at  => Time.parse('2016-01-11 11:30:35 UTC'),
      }
  end

  describe '#initialize' do
    it 'is an customerRepository' do
      expect(@collection).to be_a CustomerRepository
    end

    it 'can return an array of all known customer instances' do
      expect(@collection.all).to be_a Array
      expect(@collection.all.count).to eq 1000
      expect(@collection.all.first).to be_a Customer
      expect(@collection.all.first.id).to eq 1
    end
  end

  describe '#find_by_id' do
    it 'returns nil if no customer has the searched id' do
      expect(@collection.find_by_id(2813308004)).to eq nil
    end

    it 'can return an customer with a matching id' do
      expect(@collection.find_by_id(1)).to be_a Customer
      expect(@collection.find_by_id(1).first_name).to eq 'Joey'
    end
  end

  describe '#find_all_by_first_name' do
    it 'returns an empty array if no customer have matching first name id' do
      expect(@collection.find_all_by_first_name('Alicebryden')).to eq []
    end

    it 'returns an array if customer have matching first name' do
      expect(@collection.find_all_by_first_name("Joey").count).to eq 1
      expect(@collection.find_all_by_first_name("Cecelia").count).to eq 1
    end
  end

  describe '#find_all_by_last_name' do
    it 'returns an empty array if no customer have matching last name' do
      expect(@collection.find_all_by_last_name('Blakdensa')).to eq []
    end

    it 'returns an array if customer have matching last name' do
      expect(@collection.find_all_by_last_name('Ondricka').count).to eq 3
      expect(@collection.find_all_by_last_name('Osinski').count).to eq 3
    end
  end

  describe '#create' do
    it 'can create a new customer with provided attributes' do
      expect(@collection.find_by_id(1001)).to eq nil
      @collection.create(@attributes)
      expect(@collection.find_by_id(1001)).to be_a Customer
      expect(@collection.find_by_id(1001).first_name).to eq "Joan"
      expect(@collection.find_by_id(1001).last_name).to eq "Clarke"
      expect(@collection.find_by_id(1001).created_at).to eq Time.parse('1994-05-07 23:38:43 UTC')
      expect(@collection.find_by_id(1001).updated_at).to eq Time.parse('2016-01-11 11:30:35 UTC')
    end
  end

  describe '#update' do
    it 'can update the result of an customer' do
      expect(@collection.find_by_id(498).first_name).to eq 'Yadira'
      @collection.update(498, 'Billy', 'Bob')
      expect(@collection.find_by_id(498).first_name).to eq 'Billy'
      expect(@collection.find_by_id(498).last_name).to eq 'Bob'
      expect(@collection.find_by_id(498).updated_at).not_to eq Time.parse('2012-03-27 14:56:08 UTC')
    end
  end

  describe '#delete' do
    it 'can delete a customer based on id' do
      expect(@collection.find_by_id(1).first_name).to eq 'Joey'
      @collection.delete(1)
      expect(@collection.find_by_id(1)).to eq nil
    end
  end
end
