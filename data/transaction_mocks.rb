require './data/mockable'

class TransactionMocks
  extend Mockable

  def self.transactions_as_mocks(eg, transaction_hashes = transactions_as_hashes)
    mock_generator(eg, 'Transaction', transaction_hashes)
  end

  def self.transactions_as_hashes(number_of_hashes: 10,
                                  invoice_id: (1..10),
                                  credit_card_number: get_random_credit_card,
                                  credit_card_expiration_date: get_random_expiration,
                                  result: get_a_random_result,
                                  random_dates: true,
                                  created_at: created_at_proc,
                                  updated_at: updated_at_proc)

    generator(number_of_hashes).each_with_object([]) do |transaction_number, hashes|
      transaction = {}

      transaction[:id] = transaction_number
      transaction[:invoice_id] = (invoice_id.is_a? Range)? rand(invoice_id) : invoice_id
      transaction[:credit_card_number] = credit_card_number
      transaction[:credit_card_expiration_date] = credit_card_expiration_date
      transaction[:result] = result

      date = get_a_random_date(random_dates)
      transaction[:created_at] = created_at.call(date).to_s
      transaction[:updated_at] = updated_at.call(date).to_s

      hashes << transaction
    end
  end

  private

  def self.get_random_credit_card
    return "%d" % rand(4068_0000_0000_0000..4700_0000_0000_0000)
  end

  def self.get_random_expiration
    return "%02d%02d" % [rand(01..12), rand(22..26)]
  end

  def self.get_a_random_result
    case rand(2)
      when 0
        return 'success'
      when 1
        return 'failed'
    end
  end
end
