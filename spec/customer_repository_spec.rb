require_relative '../lib/customer'
require_relative '../lib/customer_repository'

RSpec.describe CustomerRepository do
  let(:cr) { CustomerRepository.new }
  let(:customer_1) { Customer.new({ id: 6,
                                    first_name: 'Joan',
                                    last_name: 'Clarke',
                                    created_at:  Time.now,
                                    updated_at:  Time.now }) }

  let(:customer_2) { Customer.new({ id: 2,
                                    first_name: 'Michael',
                                    last_name: 'Clarke',
                                    created_at: Time.now,
                                    updated_at: Time.now }) }

  let(:customer_3) { Customer.new({ id: 8,
                                    first_name: 'Argo',
                                    last_name: 'Angus',
                                    created_at: Time.now,
                                    updated_at: Time.now }) }

  let(:customer_4) { Customer.new({ id: 9,
                                    first_name: 'Argo',
                                    last_name: 'Angus',
                                    created_at: Time.now,
                                    updated_at: Time.now }) }

  describe '#initialize' do
    it 'exists' do
      expect(cr).to be_a(CustomerRepository)
    end

    it 'starts with no customers' do
      expect(cr.all).to eq([])
    end
  end

  describe '#add_to_repo' do
    it 'can add customers to repository' do
      cr.add_to_repo(customer_1)
      cr.add_to_repo(customer_2)
      cr.add_to_repo(customer_3)

      expect(cr.all).to eq([customer_1, customer_2, customer_3])
    end
  end

  describe '#find_by_id' do
    it 'finds an instance of customer with matching ID' do
      cr.add_to_repo(customer_1)
      cr.add_to_repo(customer_2)
      cr.add_to_repo(customer_3)

      expect(cr.find_by_id(7)).to eq(nil)
      expect(cr.find_by_id(6)).to eq(customer_1)
    end
  end

  describe '#find_all_by_first_name' do
    it 'finds all first names that match substring provided or returns []' do
      cr.add_to_repo(customer_1)
      cr.add_to_repo(customer_2)
      cr.add_to_repo(customer_3)
      cr.add_to_repo(customer_4)

      expect(cr.find_all_by_first_name('Argo')).to eq([customer_3, customer_4])
      expect(cr.find_all_by_first_name('Arg')).to eq([customer_3, customer_4])
      expect(cr.find_all_by_first_name('Jo')).to eq([customer_1])
      expect(cr.find_all_by_first_name('Prometheus')).to eq([])
    end
  end

  describe '#find_all_by_last_name' do
    it 'finds all last names that match substring provided or returns []' do
      cr.add_to_repo(customer_1)
      cr.add_to_repo(customer_2)
      cr.add_to_repo(customer_3)
      cr.add_to_repo(customer_4)

      expect(cr.find_all_by_last_name('Clark')).to eq([customer_1, customer_2])
      expect(cr.find_all_by_last_name('Prometheus')).to eq([])
    end
  end

  describe 'create(attributes)' do
    it 'creates a new Customer instance with provided attributes' do
      expect(cr.all).to eq([]) 

      cr.add_to_repo(customer_1)
      expect(cr.all.count).to eq(1)

      cr.create({ 
        first_name: 'Tron',
        last_name: 'Carter',
        created_at:  Time.now,
        updated_at:  Time.now })

      expect(cr.all.count).to eq(2)
      expect(cr.all[1].id).to eq(2)
      expect(cr.all[1].first_name).to eq('Tron')

      cr.create({ 
        first_name: 'Kathy',
        last_name: 'Peterson',
        created_at:  Time.now,
        updated_at:  Time.now })

      expect(cr.all.count).to eq(3)
      expect(cr.all[2].first_name).to eq('Kathy')
      expect(cr.all[2].last_name).to eq('Peterson')
    end
  end

  describe 'update(attributes)' do
    it 'updates customer first and last name only' do
      cr.add_to_repo(customer_1)
      cr.add_to_repo(customer_2)
      cr.add_to_repo(customer_3)

      expect(cr.all[0].first_name).to eq('Joan')
      expect(cr.all[0].last_name).to eq('Clarke')

      cr.update(6, { first_name: 'Jo-Anne', last_name: 'Clorpe', id: 22 })
      expect(cr.all[0].first_name).to eq('Jo-Anne')
      expect(cr.all[0].last_name).to eq('Clorpe')
      expect(cr.all[0].id).to eq(6)
    end
  end

  describe '#delete(id)' do
    it 'deletes an item from the customer repo' do
      cr.add_to_repo(customer_1)
      cr.add_to_repo(customer_2)
      cr.add_to_repo(customer_3)

      expect(cr.all.count).to eq(3)

      cr.delete(6)
      expect(cr.all.count).to eq(2)
      expect(cr.all).to eq([customer_2, customer_3])

      cr.delete(2)
      expect(cr.all).to eq([customer_3])
    end
  end
end