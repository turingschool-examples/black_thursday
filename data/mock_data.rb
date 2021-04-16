require 'Date'

class MockData

  DEFAULT_CREATED_AT_PROC = Proc.new {|date| date.next_year}
  DEFAULT_UPDATED_AT_PROC = Proc.new {|date| date}

  def self.mock_generator(eg, mock_name, data_hashes)
    data_hashes.each_with_object([]) do |hash, mocks|
      mocks << eg.instance_double(mock_name, hash)
    end
  end

  def self.invoices_as_mocks(eg, invoice_hashes = invoices_as_hashes)
    mock_generator(eg, 'Invoice', invoice_hashes)
  end

  def self.merchants_as_mocks(eg, merchant_hashes = merchants_as_hashes)
    mock_generator(eg, 'Merchant', merchant_hashes)
  end

  def self.items_as_mocks(eg, item_hashes = items_as_hashes)
    mock_generator(eg, 'Item', item_hashes)
  end

  def self.invoice_items_as_mocks(eg, invoice_item_hashes = invoice_items_as_hashes)
    mock_generator(eg, 'InvoiceItem', invoice_item_hashes)
  end

  def self.invoice_items_as_hashes(number_of_hashes: 10, random_dates: true,
                                   item_id_range: (1..10), invoice_id_range: (1..10),
                                   quantity: get_a_random_quantity,
                                   unit_price: get_a_random_price,
                                   created_at: DEFAULT_CREATED_AT_PROC,
                                   updated_at: DEFAULT_UPDATED_AT_PROC)
    generator = (0...number_of_hashes).to_a
    generator.each_with_object([]) do |invoice_item_number, hashes|
      invoice_item = {}

      invoice_item[:id] = invoice_item_number
      invoice_item[:item_id] = rand(item_id_range)
      invoice_item[:invoice_id] = rand(invoice_id_range)
      invoice_item[:quantity] = quantity
      invoice_item[:unit_price] = unit_price

      date = get_a_random_date(random_dates)
      invoice_item[:created_at] = created_at.call(date).to_s
      invoice_item[:updated_at] = updated_at.call(date).to_s

      hashes << invoice_item
    end
  end

  def self.invoices_as_hashes(number_of_hashes: 10, random_dates: true,
                              status: get_a_random_status, customer_id_range: (1..4),
                              merchant_id_range: (1..4),
                              created_at: DEFAULT_CREATED_AT_PROC,
                              updated_at: DEFAULT_UPDATED_AT_PROC)
    generator = (0...number_of_hashes).to_a
    generator.each_with_object([]) do |invoice_number, hashes|
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

  def self.merchants_as_hashes(number_of_hashes: 10, random_dates: true,
                               created_at: DEFAULT_CREATED_AT_PROC,
                               updated_at: DEFAULT_UPDATED_AT_PROC)
    generator = (0...number_of_hashes).to_a
    generator.each_with_object([]) do |merchant_number, hashes|
      merchant = {}

      merchant[:name] = "Merchant #{merchant_number}"
      merchant[:id] = merchant_number

      date = get_a_random_date(random_dates)
      merchant[:created_at] = created_at.call(date).to_s
      merchant[:updated_at] = updated_at.call(date).to_s

      hashes << merchant
    end
  end

  def self.items_as_hashes(number_of_hashes: 10, number_of_merchants: 2,
                           random_dates: true, unit_price: get_a_random_price,
                           created_at: DEFAULT_CREATED_AT_PROC,
                           updated_at: DEFAULT_UPDATED_AT_PROC)
    generator = (0...number_of_hashes).to_a
    generator.each_with_object([]) do |item_number, hashes|
      item = {}

      item[:name] = "Item #{item_number}"
      item[:id] = item_number
      item[:unit_price] = unit_price
      item[:description] = 'Item Description'
      item[:merchant_id] = item_number % number_of_merchants

      date = get_a_random_date(random_dates)
      item[:created_at] = created_at.call(date).to_s
      item[:updated_at] = updated_at.call(date).to_s

      hashes << item
    end
  end

  def self.sum_item_prices_from_hash(items)
    items.sum do |item|
      item[:unit_price]
    end
  end

  def self.mean_of_item_prices_from_hash(items)
    sum = sum_item_prices_from_hash(items)
    (sum / items.length)
  end

  def self.date_format
    /\d{4}-\d{2}-\d{2}/
  end

  def self.get_a_random_date(random = true)
    if random
      date_s = "20#{rand(10..21)}-#{rand(1..12)}-#{rand(1..28)}"
      return Date.strptime(date_s, '%Y-%m-%d')
    else
      return Date.strptime('2020-01-01', '%Y-%m-%d')
    end
  end

  def self.get_a_random_quantity
    rand(1..20)
  end

  def self.get_a_random_price
    (rand(1..120) + (rand(100) / 100.0))
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
