require '.test/test_helper'
require './lib/invoice_items_repository'
require './lib/file_loader'

class InvoiceItemsRepositoryTest < Minitest::Test
  include FileLoader

  def setup
    @mock_data = [
      {:id        => 6,
      :item_id    => 7,
      :invoice_id => 8,
      :quantity   => 1,
      :unit_price => BigDecimal.new(5.99, 3),
      :created_at => Time.now,
      :updated_at => Time.now},
      {:id        => 7,
      :item_id    => 7,
      :invoice_id => 9,
      :quantity   => 1,
      :unit_price => BigDecimal.new(7.99, 3),
      :created_at => Time.now,
      :updated_at => Time.now},
      {:id        => 8,
      :item_id    => 8,
      :invoice_id => 9,
      :quantity   => 1,
      :unit_price => BigDecimal.new(10.99, 4),
      :created_at => Time.now,
      :updated_at => Time.now},
      {:id        => 9,
      :item_id    => 9,
      :invoice_id => 8,
      :quantity   => 1,
      :unit_price => BigDecimal.new(12.99, 4),
      :created_at => Time.now,
      :updated_at => Time.now}
      ]

    @invoice_items_repo = InvoiceItemsRepository.new(@mock_data)
  end

  def test_it_exists
    assert_instance_of InvoiceItemsRepository, @invoice_items_repo
  end

end
