require_relative 'spec_helper'
require "Rspec"
require_relative "../lib/customer_repo"


describe CustomerRepo do
  before :each do
    @cr = CustomerRepo.new('./data/customers.csv')
  end

  it 'is an instance of CustomerRepo' do
    expect(@cr).to be_a CustomerRepo
  end

  it 'creates an array of hashes from the csv' do
    expect(@cr.to_array).to be_a Array
    expect(@cr.to_array.empty?).to be false
  end

  it '#all' do
    expect(@cr.all).to be_a Array
    expect(@cr.all.empty?).to be false
    expect(@cr.all[0]).to be_a Customer
    expect(@cr.all.length).to eq 1000
  end

  it '#find_by_id' do
    expect(@cr.find_by_id(850)).to be_a Customer
    expect(@cr.find_by_id(850).first_name).to eq 'Shane'
    expect(@cr.find_by_id(-1)).to eq nil
  end

  it '#find_all_by_first_name' do
    expect(@cr.find_all_by_first_name('Shane').length).to eq 3
    expect(@cr.find_all_by_first_name('Shane')).to be_a Array
  end

  it '#find_all_by_last_name' do
    expect(@cr.find_all_by_last_name('Purdy').length).to eq 5
    expect(@cr.find_all_by_last_name('Purdy')).to be_a Array
  end

  it '#create' do
    @cr.create({
      first_name: 'Gregory',
      last_name: 'Fischer',
      created_at: Time.now.utc,
      updated_at: Time.now.utc
      })

    expect(@cr.find_all_by_first_name('Gregory').length).to eq 2
  end

  it '#update' do
    @cr.update(1, {first_name: 'Fred', last_name: 'Joe'})

    expect(@cr.find_by_id(1).first_name).to eq('Fred')
    expect(@cr.find_by_id(1).last_name).to eq('Joe')
  end

  it '#delete' do
    @cr.create({
      first_name: 'Gregory',
      last_name: 'Fischer',
      created_at: Time.now.utc,
      updated_at: Time.now.utc
      })

    @cr.delete(1001)

    expect(@cr.find_by_id(1001)).to eq nil
  end
end
