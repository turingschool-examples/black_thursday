require './lib/invoice'
require 'RSpec'

RSpec.describe Invoice do
  describe '#initialize' do
    i = Invoice.new(
      id:           6,
      customer_id:  7,
      merchant_id:  8,
      status:       'pending',
      created_at:   Time.now.to_s,
      updated_at:   Time.now.to_s,
      repository:   'repository'
    )
    it 'exists' do
      expect(i).to be_an_instance_of(Invoice)
    end
  end

  describe 'instance variables' do
    i = Invoice.new(
      id:           6,
      customer_id:  7,
      merchant_id:  8,
      status:       'pending',
      created_at:   Time.now.to_s,
      updated_at:   Time.now.to_s,
      repository:   'repository'
    )
    it 'has an id' do
      expect(i.id).to eq(6)
    end
    it 'has a customer id' do
      expect(i.customer_id).to eq(7)
    end
    it 'has a merchant id' do
      expect(i.merchant_id).to eq(8)
    end
    it 'has a status' do
      expect(i.status).to eq('pending')
    end
    # it 'has a repository' do
    #   expect(i.repository).to eq('repository')
    # end
  end

  describe 'instances of time' do
    it 'has a time created' do
      allow(Time).to receive(:now) do
        '12:58'
      end
      i = Invoice.new(
        id:           6,
        customer_id:  7,
        merchant_id:  8,
        status:       'pending',
        created_at:   Time.now.to_s,
        updated_at:   Time.now.to_s,
        repository:   'repository'
      )

      expect(i.created_at).to eq('12:58')
    end
    it 'has a time updated' do
      allow(Time).to receive(:now) do
        '12:58'
      end
      i = Invoice.new(
        id:           6,
        customer_id:  7,
        merchant_id:  8,
        status:       'pending',
        created_at:   Time.now.to_s,
        updated_at:   Time.now.to_s,
        repository:   'repository'
      )
      expect(i.updated_at).to eq('12:58')
    end
  end
end
