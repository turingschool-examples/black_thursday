require './data/mockable'

class InvoiceItemMocks
  extend Mockable

  def self.invoice_items_as_mocks(eg, invoice_item_hashes = invoice_items_as_hashes)
    mock_generator(eg, 'InvoiceItem', invoice_item_hashes)
  end

  def self.invoice_items_as_hashes(number_of_hashes: 10, random_dates: true,
                                   item_id: (1..10), invoice_id: (1..10),
                                   quantity: get_a_random_quantity,
                                   unit_price: get_a_random_price,
                                   created_at: created_at_proc,
                                   updated_at: updated_at_proc)

    generator(number_of_hashes).each_with_object([]) do |invoice_item_number, hashes|
      invoice_item = {}

      invoice_item[:id] = invoice_item_number
      invoice_item[:item_id] = (item_id.is_a? Range)? rand(item_id) : item_id
      invoice_item[:invoice_id] = (invoice_id.is_a? Range)? rand(invoice_id) : invoice_id
      invoice_item[:quantity] = quantity
      invoice_item[:unit_price] = unit_price

      date = get_a_random_date(random_dates)
      invoice_item[:created_at] = created_at.call(date).to_s
      invoice_item[:updated_at] = updated_at.call(date).to_s

      hashes << invoice_item
    end
  end
end
