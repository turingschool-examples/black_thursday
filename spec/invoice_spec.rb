require 'rspec'
require './lib/invoice'

describe Invoice do
  describe '#initialize' do
    xit 'exists' do
      i = Invoice.new({
                        id: 6,
                        customer_id: 7,
                        merchant_id: 8,
                        status: 'pending',
                        created_at: Time.now,
                        updated_at: Time.now
                      })

      expect(i).is_a? Invoice
    end

    xit 'has an id' do
      i = Invoice.new({
                        id: 6,
                        customer_id: 7,
                        merchant_id: 8,
                        status: 'pending',
                        created_at: Time.now,
                        updated_at: Time.now
                      })

      expect(i.id).to eq 6
      expect(i.id).is_a? Integer
    end

    xit 'has a customer id' do
      i = Invoice.new({
                        id: 6,
                        customer_id: 7,
                        merchant_id: 8,
                        status: 'pending',
                        created_at: Time.now,
                        updated_at: Time.now
                      })

      expect(i.customer_id).to eq 7
      expect(i.customer_id).is_a? Integer
    end

    xit 'has a merchant id' do
      i = Invoice.new({
                        id: 6,
                        customer_id: 7,
                        merchant_id: 8,
                        status: 'pending',
                        created_at: Time.now,
                        updated_at: Time.now
                      })

      expect(i.merchant_id).to eq 8
      expect(i.merchant_id).is_a? Integer
    end

    xit 'has a status' do
      i = Invoice.new({
                        id: 6,
                        customer_id: 7,
                        merchant_id: 8,
                        status: 'pending',
                        created_at: Time.now,
                        updated_at: Time.now
                      })

      expect(i.status).to eq 'pending'
      expect(i.status).is_a? String
    end

    it 'time stamps when created' do
      created_at = MockData.get_a_random_date false
      updated_at = MockData.get_a_random_date false

      invoice = Invoice.new({
                              id: 6,
                              customer_id: 7,
                              merchant_id: 8,
                              status: 'pending',
                              created_at: created_at,
                              updated_at: updated_at
                            })

      expect(invoice.created_at).to eq created_at
      expect(invoice.updated_at).to eq updated_at
    end

    xit 'time stamps when updated' do
      time = Time.now
      i = Invoice.new({
                        id: 6,
                        customer_id: 7,
                        merchant_id: 8,
                        status: 'pending',
                        created_at: Time.now,
                        updated_at: Time.now
                      })

      expect(i.updated_at).to eq(time)
      expect(i.updated_at).is_a? Time
    end
  end
end
