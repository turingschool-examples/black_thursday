require './data/mockable'

class MerchantMocks
  extend Mockable

  def self.merchants_as_mocks(eg, merchant_hashes = merchants_as_hashes)
    mock_generator(eg, 'Merchant', merchant_hashes)
  end

  def self.merchants_as_hashes(number_of_hashes: 10, random_dates: true,
                               created_at: created_at_proc,
                               updated_at: updated_at_proc)

    generator(number_of_hashes).each_with_object([]) do |merchant_number, hashes|
      merchant = {}

      merchant[:name] = "Merchant #{merchant_number}"
      merchant[:id] = merchant_number

      date = get_a_random_date(random_dates)
      merchant[:created_at] = created_at.call(date).to_s
      merchant[:updated_at] = updated_at.call(date).to_s

      hashes << merchant
    end
  end
end
