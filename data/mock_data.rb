require 'Date'

class MockData

  NO_SELF_ERROR_MESSAGE = 'use {self} at the end of your *_as_mocks method'

  def self.get_a_random_date(random = true)
    if random
      date_s = "20#{rand(10..21)}-#{rand(1..12)}-#{rand(1..28)}"
      return Date.strptime(date_s, '%Y-%m-%d')
    else
      return Date.strptime('2020-01-01', '%Y-%m-%d')
    end
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

  def self.invoices_as_mocks(invoice_hashes)
    mocked_invoices = []
    invoice_hashes.each do |invoice_hash|
      raise NO_SELF_ERROR_MESSAGE if not block_given?
      eg = yield
      invoice_mock = eg.instance_double('Invoice',
        id: invoice_hash[:id],
        customer_id: invoice_hash[:customer_id],
        merchant_id: invoice_hash[:merchant_id],
        created_at: invoice_hash[:created_at],
        updated_at: invoice_hash[:updated_at]
      )
      mocked_invoices << invoice_mock
    end
    mocked_invoices
  end

  def self.invoices_as_hashes(number_of_mocks: 10, random_dates: true,
                            custom_status: nil, customer_id_range: (1..4),
                            merchant_id_range: (1..4))
    mocked_invoices = []
    number_of_mocks.times do |invoice_number|
      invoice = {}
      date = get_a_random_date(random_dates)
      invoice[:status] = (custom_status.nil?)? get_a_random_status : custom_status
      invoice[:id] = invoice_number
      invoice[:customer_id] = rand(customer_id_range)
      invoice[:merchant_id] = rand(merchant_id_range)
      if block_given?
        invoice[:created_at] = yield(date).to_s
        invoice[:updated_at] = date.to_s
      else
        invoice[:created_at] = date.prev_month.to_s
        invoice[:updated_at] = date.to_s
      end
      mocked_invoices << invoice
    end
    mocked_invoices
  end

  def self.merchants_as_mocks(merchant_hashes)
    mocked_merchants = []

    merchant_hashes.each do |merchant_hash|
      raise NO_SELF_ERROR_MESSAGE if not block_given?
      eg = yield
      merchant_mock = eg.instance_double('Merchant',
        name: merchant_hash[:name],
        id: merchant_hash[:id],
        created_at: merchant_hash[:created_at],
        updated_at: merchant_hash[:updated_at]
      )
      mocked_merchants << merchant_mock
    end
    mocked_merchants
  end

  def self.merchants_as_hashes(number_of_mocks: 10, random_dates: true)
    mocked_merchants = []
    number_of_mocks.times do |merchant_number|
      merchant = {}
      date = get_a_random_date(random_dates)

      merchant[:name] = "Merchant #{merchant_number}"
      merchant[:id] = merchant_number
      if block_given?
        merchant[:created_at] = yield(date).to_s
        merchant[:updated_at] = date.to_s
      else
        merchant[:created_at] = date.prev_year.to_s
        merchant[:updated_at] = date.to_s
      end
      mocked_merchants << merchant
    end
    mocked_merchants
  end

  def self.items_as_mocks(item_hashes)
    mocked_items = []
    item_hashes.each do |item_hash|
      raise NO_SELF_ERROR_MESSAGE if not block_given?
      eg = yield
      item = eg.instance_double('Item',
        name: item_hash[:name],
        id: item_hash[:id],
        unit_price: item_hash[:unit_price],
        description: item_hash[:description],
        merchant_id: item_hash[:merchant_id],
        created_at: item_hash[:created_at],
        updated_at: item_hash[:updated_at]
      )
      mocked_items << item
    end
    mocked_items
  end

  def self.items_as_hashes(number_of_mocks: 10, number_of_merchants: 2, random_dates: true, price_of: 0)
    mocked_items = []
    number_of_mocks.times do |item_number|
      item = {}
      date = get_a_random_date(random_dates)
      item[:name] = "Item #{item_number}"
      item[:id] = item_number
      if price_of == 0
        item[:unit_price] = get_a_random_price
      else
        item[:unit_price] = price_of
      end
      item[:description] = 'Item Description'
      item[:merchant_id] = item_number % number_of_merchants
      if block_given?
        item[:created_at] = yield(date).to_s
        item[:updated_at] = date.to_s
      else
        item[:created_at] = date.prev_year.to_s
        item[:updated_at] = date.to_s
      end
      mocked_items << item
    end
    mocked_items
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
end
