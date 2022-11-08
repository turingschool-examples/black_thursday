require './lib/requirements'

RSpec.describe CustomerRepository do

  let!(:customer_repository) {CustomerRepository.new("./data/customers.csv", nil)}

  it 'is a customer repository class' do
    expect(customer_repository).to be_a(CustomerRepository)
  end
  
  it 'can return all customers' do
    expect(customer_repository.all).to be_a(Array)
    expect(customer_repository.all.length).to eq(1000)
  end
  
  it 'can find a customer by id' do
    expect(customer_repository.find_by_id(4)).to eq(customer_repository.all[3])
  end
  
  it 'can find all customers by first name' do
    expect(customer_repository.find_all_by_first_name("earl")).to eq([customer_repository.all[220], customer_repository.all[406], customer_repository.all[484]])
  end
  
  it 'can find all customers by last name' do
    expect(customer_repository.find_all_by_last_name("metz")).to eq([customer_repository.all[305], customer_repository.all[406]])
  end
  
  it 'can create a new customer, which has the last id + 1' do
    expect(customer_repository.all.last.id).to eq(1000)
    
    customer_repository.create({
      :first_name => "John",
      :last_name => "Smith",
      :created_at => Time.now,
      :updated_at => Time.now
    })
    
    expect(customer_repository.all.last.id).to eq(1001)
    expect(customer_repository.all.last.first_name).to eq("John")   
  end

  it 'can update a customer' do
    expect(customer_repository.find_by_id(4).first_name).to eq("Leanne")
    
    customer_repository.update(4, {:first_name => "Leslie", :last_name => "Dahlin"})
    
    expect(customer_repository.find_by_id(4).first_name).to eq("Leslie")
  end
  
  it 'can delete a customer' do
    expect(customer_repository.all.length).to eq(1000)
    
    customer_repository.delete(4)

    expect(customer_repository.all.length).to eq(999)
  end
  
end