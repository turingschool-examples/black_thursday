require 'Date'

module ItemMock

end

class MockData
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

  def self.merchants_as_mocks(merchant_hashes)
    mocked_merchants = []

    merchant_hashes.each do |merchant_hash|
      raise 'Bind self of ExampleGroup to your mocks. use {self}' if not block_given?
      eg = yield
      merchant_mock = eg.instance_double('Merchant Mock')
      eg.allow(merchant_mock).to eg.receive(:name).and_return(merchant_hash[:name])
      eg.allow(merchant_mock).to eg.receive(:id).and_return(merchant_hash[:id])

      eg.allow(merchant_mock).to eg.receive(:created_at).and_return(merchant_hash[:created_at])
      eg.allow(merchant_mock).to eg.receive(:updated_at).and_return(merchant_hash[:updated_at])

      mocked_merchants << merchant_mock
    end
    mocked_merchants
  end

  def self.merchants_as_hash(number_of_mocks: 10, random_dates: true)
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

  def self.items_as_mocks(number_of_mocks: 10, number_of_merchants: 2, random_dates: true, price_of: 0)
    mocked_items = []
    item_hashes = items_as_hash(number_of_mocks: number_of_mocks,
                                number_of_merchants: number_of_merchants,
                                random_dates: random_dates,
                                price_of: price_of)
    item_hashes.each do |item_hash|
      raise 'Bind self of ExampleGroup to your mocks. use {self}' if not block_given?
      eg = yield
      item = eg.instance_double('Item Mock')
      eg.allow(item).to eg.receive(:name).and_return(item_hash[:name])
      eg.allow(item).to eg.receive(:id).and_return(item_hash[:id])

      eg.allow(item).to eg.receive(:unit_price).and_return(item_hash[:unit_price])

      eg.allow(item).to eg.receive(:description).and_return(item_hash[:description])
      eg.allow(item).to eg.receive(:merchant_id).and_return(item_hash[:merchant_id])

      eg.allow(item).to eg.receive(:created_at).and_return(item_hash[:created_at])
      eg.allow(item).to eg.receive(:updated_at).and_return(item_hash[:updated_at])

      mocked_items << item
    end
    mocked_items
  end

  def self.items_as_hash(number_of_mocks: 10, number_of_merchants: 2, random_dates: true, price_of: 0)
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

  def self.sum_item_prices(items)
    items.sum do |item|
      item[:unit_price]
    end
  end

  def self.mean_of_item_prices(items)
    sum = sum_item_prices(items)
    (sum / items.length)
  end
end
