require 'rspec'
require './lib/customer'

describe Customer do
  before (:each) do
    @c = Customer.new({
      :id => 6,
      :first_name => "Joan",
      :last_name => "Clarke",
      :created_at => "02-26-2022",
      :updated_at => "02-27-2022"
      })
    end

  describe '#initialize' do
    it 'exists' do
      expect(@c).to be_an_instance_of(Customer)
    end

    it 'has an id' do
      expect(@c.id).to eq(6)
    end

    it 'has a name' do
      expect(@c.first_name).to eq("Joan")
      expect(@c.last_name).to eq("Clarke")
    end

    it 'can tell you what time something was created and updated' do
      expect(@c.created_at).to eq("02-26-2022")
      expect(@c.updated_at).to eq("02-27-2022")
    end
  end
end
