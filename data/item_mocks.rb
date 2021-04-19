require './data/mockable'

class ItemMocks
  extend Mockable

  def self.items_as_mocks(eg, item_hashes = items_as_hashes)
    mock_generator(eg, 'Item', item_hashes)
  end

  def self.items_as_hashes(number_of_hashes: 10, merchant_id: (1..2),
                           random_dates: true, unit_price: get_a_random_price,
                           created_at: created_at_proc,
                           updated_at: updated_at_proc)

    generator(number_of_hashes).each_with_object([]) do |item_number, hashes|
      item = {}

      item[:name] = "Item #{item_number}"
      item[:id] = item_number
      item[:unit_price] = unit_price
      item[:description] = 'Item Description'
      item[:merchant_id] = (merchant_id.is_a? Range)? rand(merchant_id) : merchant_id

      date = get_a_random_date(random_dates)
      item[:created_at] = created_at.call(date).to_s
      item[:updated_at] = updated_at.call(date).to_s

      hashes << item
    end
  end
end
