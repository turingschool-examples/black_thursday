require './data/mockable'

class InvoiceMocks
  extend Mockable

  def self.invoices_as_mocks(eg, invoice_hashes = invoices_as_hashes)
    mock_generator(eg, 'Invoice', invoice_hashes)
  end

  def self.invoices_as_hashes(number_of_hashes: 10, random_dates: true,
                              status: get_a_random_status, customer_id_range: (1..4),
                              merchant_id_range: (1..4),
                              created_at: created_at_proc,
                              updated_at: updated_at_proc)

    generator(number_of_hashes).each_with_object([]) do |invoice_number, hashes|
      invoice = {}

      invoice[:status] = status
      invoice[:id] = invoice_number
      invoice[:customer_id] = rand(customer_id_range)
      invoice[:merchant_id] = rand(merchant_id_range)

      date = get_a_random_date(random_dates)
      invoice[:created_at] = created_at.call(date).to_s
      invoice[:updated_at] = updated_at.call(date).to_s

      hashes << invoice
    end
  end

  def self.get_a_random_status
    case rand(3)
      when 0
        return 'pending'
      when 1
        return 'shipped'
      when 2
        return 'returned'
    end
  end
end
