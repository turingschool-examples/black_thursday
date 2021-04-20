require './lib/invoice'

describe Invoice do
  describe '#initialize' do
    it 'exists' do
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

    it 'has an id' do
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

    it 'has a customer id' do
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

    it 'has a merchant id' do
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

    it 'has a status' do
      i = Invoice.new({
                        id: 6,
                        customer_id: 7,
                        merchant_id: 8,
                        status: 'pending',
                        created_at: Time.now,
                        updated_at: Time.now
                      })

      expect(i.status).to eq :pending
      expect(i.status).is_a? String
    end

    it 'has time stamps' do
      created_at = '2021-01-01'
      updated_at = '2021-01-06'

      invoice = Invoice.new({
                              id: 6,
                              customer_id: 7,
                              merchant_id: 8,
                              status: 'pending',
                              created_at: created_at,
                              updated_at: updated_at
                            })

      expect(invoice.created_at).to eq Time.parse(created_at)
      expect(invoice.updated_at).to eq Time.parse(updated_at)
    end

    it 'updates id' do
      i = Invoice.new({
                        id: 6,
                        customer_id: 7,
                        merchant_id: 8,
                        status: 'pending',
                        created_at: Time.now,
                        updated_at: Time.now
                      })
      i.update_id(7)
      expect(i.id).to eq 7
    end

    it 'updates status' do
      i = Invoice.new({
                        id: 10,
                        customer_id: 7,
                        merchant_id: 8,
                        status: 'pending',
                        created_at: Time.now,
                        updated_at: Time.now
                      })

      i.update_status('shipped')
      expect(i.status).to eq 'shipped'
    end

    it 'updates time updated' do
      i = Invoice.new({
                        id: 10,
                        customer_id: 7,
                        merchant_id: 8,
                        status: 'pending',
                        created_at: Time.now,
                        updated_at: Time.new(2020, 12, 31)
                      })

      i.update_time
      expect(i.updated_at).to be > Time.new(2020, 12, 31)
    end
  end
end
