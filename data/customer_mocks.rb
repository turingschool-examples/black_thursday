require './data/mockable'

class CustomerMocks
  extend Mockable

  def self.customers_as_mocks(eg, customer_hashes = customers_as_hashes)
    mock_generator(eg, 'Customer', customer_hashes)
  end

  def self.customers_as_hashes(number_of_hashes: 10, random_dates: true,
                               first_name: 'First Name',
                               last_name: 'Last Name',
                               created_at: created_at_proc,
                               updated_at: updated_at_proc)
    generator(number_of_hashes).each_with_object([]) do |customer_number, hashes|
      customer = {}

      customer[:id] = customer_number
      customer[:first_name] = first_name
      customer[:last_name] = last_name

      date = get_a_random_date(random_dates)
      customer[:created_at] = created_at.call(date).to_s
      customer[:updated_at] = updated_at.call(date).to_s

      hashes << customer
    end
  end
end
