require_relative 'spec_helper'

RSpec.describe MerchantRepository do
  describe '#initialize' do
    it 'exists' do
      path = "fixture/merchant_fixture.csv"
      merchant_repo = MerchantRepository.new(path)

      expect(merchant_repo).to be_a(MerchantRepository)
    end

    it 'has an array of all merchant instances' do
      path = 'fixture/merchant_fixture.csv'
      merchant_repo = MerchantRepository.new(path)

      expect(merchant_repo.all.length).to eq(5)
    end
  end

  describe 'attributes' do
    it 'can read Merchant attributes' do
      path = 'fixture/merchant_fixture.csv'
      merchant_repo = MerchantRepository.new(path)

      # creates new object instance of merchant objects?
      all = merchant_repo.all

      expect(all.first.id).to eq(12334471)
      expect(all.first.name).to eq('Hollipoop')
    end

    it 'can find Merchant by ID' do
      path = 'fixture/merchant_fixture.csv'
      merchant_repo = MerchantRepository.new(path)

      merchant_repo.create_merchants(path)

      id = 12337011
      expected = merchant_repo.find_by_id(id)

      expect(expected.id).to eq(id)
    end

    it 'can find Merchant by name' do
      path = 'fixture/merchant_fixture.csv'
      merchant_repo = MerchantRepository.new(path)

      merchant_repo.create_merchants(path)

      expect(merchant_repo.find_by_name('hollipoop')).to eq(merchant_repo.all.first)
      expect(merchant_repo.find_by_name('HOLLIPOOP')).to eq(merchant_repo.all.first)
    end

    it 'can find all merchants by name fragment' do
      path = 'fixture/merchant_fixture.csv'
      merchant_repo = MerchantRepository.new(path)

      name = 'french'
      expected = merchant_repo.find_all_by_name(name)

      expect(expected).to be_a(Array)
      expect(expected.length).to eq(2)
      expect(expected.first).to be_a(Merchant)
      expect(expected.first.id).to eq(12334473)
      expect(merchant_repo.find_all_by_name('hasasldkjf')).to eq([])
    end
  end

  describe 'creates attributes' do
    it 'creates a merchant' do
      path = 'fixture/merchant_fixture.csv'
      merchant_repo = MerchantRepository.new(path)

      attributes = {:id => nil,
                    :name => 'Elliotpooped',
                    :created_at => '1989-03-14',
                    :updated_at => '1995-09-14'
                  }
      merchant_repo.create(attributes)
      expect(merchant_repo.all.length).to eq(6)
      expect(merchant_repo.all.last.name).to eq('Elliotpooped')
      expect(merchant_repo.all.last.id).to eq(12337012)
    end

    it 'updates attributes' do
      path = 'fixture/merchant_fixture.csv'
      merchant_repo = MerchantRepository.new(path)
      attributes = {name: 'ShestheMan'}

      merchant_repo.update(12335150, attributes)

      expect(merchant_repo.all[4].name).to eq('ShestheMan')
    end

    it 'deletes a merchant using id' do
      path = 'fixture/merchant_fixture.csv'
      merchant_repo = MerchantRepository.new(path)
      merchant_repo.delete(12337012)

      expect(merchant_repo.all.length).to eq(5)
    end
  end
end
