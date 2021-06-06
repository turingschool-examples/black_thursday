require 'SimpleCov'
SimpleCov.start

require_relative '../lib/customer_repository'
require_relative '../lib/customer'

RSpec.describe CustomerRepository do
  before(:each) do
    @cr = CustomerRepository.new('./spec/fixture_files/customer_fixture.csv')
  end

  it 'exists' do
    expect(@cr).to be_an_instance_of(CustomerRepository)
  end

  it 'can create a customer object' do
    expect(@cr.all[0]).to be_an_instance_of(Customer)
  end

  it 'returns a list of all customers' do
    expect(@cr.all.length).to eq(10)
  end

  it 'can find a customer by id' do
    expect(@cr.find_by_id(6).first_name).to eq('Gunnvaldr')
  end

  it 'can find all customers by first name' do
    expect(@cr.find_all_by_first_name('Fen').length).to eq(2)
  end

  it 'can find all customers by last name' do
    expect(@cr.find_all_by_first_name('Fen').length).to eq(2)
  end

  it 'can create a new customer' do
    new = @cr.create({
                :first_name => 'Jennifer',
                :last_name => 'Flowers'
              })

    expect(@cr.all.length).to eq(11)
    expect(new.id).to eq(11)
  end

  it 'can update attributes of a customer' do
    @cr.update(5, {:first_name => 'Dileep'})

    expect(@cr.find_by_id(5).first_name).to eq('Dileep')
    expect(@cr.find_by_id(5).last_name).to eq('Bosch')
    expect(@cr.find_by_id(5).updated_at).to_not eq(@cr.find_by_id(5).created_at)
  end

  it 'can delete customer by id' do
    @cr.delete(7)

    expect(@cr.all.length).to eq(9)
  end
end
