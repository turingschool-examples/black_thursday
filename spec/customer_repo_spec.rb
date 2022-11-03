# frozen_string_literal: true

require './lib/customer'
require './lib/customer_repo'
require 'CSV'

describe CustomerRepo do
  before(:each) do
    filepath = { :customer => './data/customers.csv' }.values[0]
    @data = CSV.readlines(filepath, headers: true, header_converters: :symbol)
    @data = @data[0..4]
    @se = 'EMPTY_SE'
    @cr = CustomerRepo.new(@data, @se)
    @customer1 = @cr.all[0]
    @customer2 = @cr.all[1]
    @customer3 = @cr.all[2]
    @customer4 = @cr.all[3]
    @customer5 = @cr.all[4]
  end

  describe '#initialization' do
    it 'exists' do
      expect(@cr).to be_instance_of(CustomerRepo)
    end
  end

  describe '#create' do
    it 'creates an customer based on the values passed in' do
      @cr.create(
        id:                          1,
        first_name:                  'Joey',
        last_name:                   'Ondricka',
        created_at:                  Time.now,
        updated_at:                  Time.now
      )

      expect(@cr.all.last.last_name).to eq('Ondricka')
    end
  end

  describe '#all' do
    it 'returns list of all added customers' do
      expect(@cr.all).to eq([@customer1, @customer2, @customer3, @customer4, @customer5])
    end
  end

  describe '#find_by_id' do
    it 'searches for specific customer id and returns customer or nil if empty' do
      expect(@cr.find_by_id(1)).to eq(@customer1)
      expect(@cr.find_by_id(10)).to eq(nil)
    end
  end

  describe '#find_all_by_first_name' do
    it 'searches for a first_name and returns customers with that name or empty array' do
      expect(@cr.find_all_by_first_name('Joey')).to eq([@customer1])
      expect(@cr.find_all_by_first_name('NOTANAME')).to eq([])
    end
  end

  describe '#find_all_by_last_name' do
    it 'searches for a last_name and returns customers found or empty array' do
      expect(@cr.find_all_by_last_name('Toy')).to eq([@customer3])
      expect(@cr.find_all_by_last_name('NOTANAME')).to eq([])
    end
  end

  describe '#update' do
    it 'updates the values of the customer at id with attributes passed in' do
      expect(@customer1.first_name).to eq('Joey')
      @cr.update(1, { first_name: 'Tim', last_name: 'Overton' })
      expect(@customer1.first_name).to eq('Tim')
      expect(@customer1.last_name).to eq('Overton')
    end
  end

  describe '#delete' do
    it 'deletes the item at the specified id index' do
      @cr.delete(1)
      expect(@cr.all).to eq([@customer2, @customer3, @customer4, @customer5])
    end
  end
end
