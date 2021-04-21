require 'customer'

RSpec.describe Customer do
  describe 'instantiation' do
    it '::new' do
      mock_repo = double('CustomerRepo')
      customer = Customer.new({:id => 6,
                               :first_name => 'Joan',
                               :last_name => 'Clarke',
                               :created_at => Time.now,
                               :updated_at => Time.now}, mock_repo)

      expect(customer).to be_an_instance_of(Customer)
    end

    it 'has attributes' do
      mock_repo = double('CustomerRepo')
      customer = Customer.new({:id => 6,
                               :first_name => 'Joan',
                               :last_name => 'Clarke',
                               :created_at => Time.now,
                               :updated_at => Time.now}, mock_repo)

      expect(customer.id).to eq(6)
      expect(customer.first_name).to eq('Joan')
      expect(customer.last_name).to eq('Clarke')
      expect(customer.created_at).to be_an_instance_of(Time)
      expect(customer.updated_at).to be_an_instance_of(Time)
    end
  end

  describe '#methods' do
    it 'update first name' do
      mock_repo = double('CustomerRepo')
      customer = Customer.new({:id => 6,
                               :first_name => 'Joan',
                               :last_name => 'Clarke',
                               :created_at => Time.now,
                               :updated_at => Time.now}, mock_repo)
    
      customer.update_first_name({:first_name => 'Lars'})     

      expect(customer.first_name).to eq('Lars')

      customer.update_first_name({:id => 'Lars'}) 

      expect(customer.first_name).to eq('Lars')
    end

    it 'update last name' do
      mock_repo = double('CustomerRepo')
      customer = Customer.new({:id => 6,
                                :first_name => 'Joan',
                                :last_name => 'Clarke',
                                :created_at => Time.now,
                                :updated_at => Time.now}, mock_repo)

      customer.update_last_name({:last_name => 'Mars'})     

      expect(customer.last_name).to eq('Mars')

      customer.update_last_name({:id => 'Mars'}) 
        
      expect(customer.last_name).to eq('Mars')
    end

    it 'update updated at' do
      mock_repo = double('CustomerRepo')
      customer = Customer.new({:id => 6,
                               :first_name => 'Joan',
                               :last_name => 'Clarke',
                               :created_at => Time.now,
                               :updated_at => Time.now}, mock_repo)

      customer.update_updated_at({:updated_at => Time.now})
  
      expect(customer.updated_at).to be_an_instance_of(Time)
    end

    it 'update id' do
      mock_repo = double('CustomerRepo')
      customer = Customer.new({:id => 6,
                               :first_name => 'Joan',
                               :last_name => 'Clarke',
                               :created_at => Time.now,
                               :updated_at => Time.now}, mock_repo)

      new_id = 1000
      customer.update_id(new_id)
  
      expect(customer.id).to eq 1001
    end
  end
end
