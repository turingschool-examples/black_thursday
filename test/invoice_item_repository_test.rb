require 'simplecov'
SimpleCov.start
require 'minitest/pride'
require 'minitest/autorun'
require_relative '../lib/invoice_item'
require_relative '../lib/invoice_item_repository'

class InvoiceItemRepositoryTest < Minitest::Test

  def setup
    @invoice_item_repository = InvoiceItemRepository.new
    @invoice_item_repository.create_with_id({id: 1,
                                             item_id: 1,
                                             invoice_id: 1,
                                             quantity: 1,
                                             unit_price: 100,
                                             created_at: "2018-01-01",
                                             updated_at: "2018-01-01"
                                             })
    @invoice_item_repository.create_with_id({id: 2,
                                             item_id: 2,
                                             invoice_id: 2,
                                             quantity: 2,
                                             unit_price: 200,
                                             created_at: "2018-01-01",
                                             updated_at: "2018-01-01"
                                             })
    @invoice_item_repository.create_with_id({id: 3,
                                             item_id: 3,
                                             invoice_id: 3,
                                             quantity: 3,
                                             unit_price: 300,
                                             created_at: "2018-01-01",
                                             updated_at: "2018-01-01"
                                             })
    @invoice_item_repository.create_with_id({id: 4,
                                             item_id: 3,
                                             invoice_id: 3,
                                             quantity: 4,
                                             unit_price: 400,
                                             created_at: "2018-01-01",
                                             updated_at: "2018-01-01"
                                             })
    end

    def test_it_exists
      assert_instance_of InvoiceItemRepository, @invoice_item_repository
    end

    def test_it_starts_with_no_invoice_items
      repo = InvoiceItemRepository.new
      assert_equal repo.all, []
    end

    def test_we_can_find_by_id
      expected = 4
      result = @invoice_item_repository.find_by_id(4).id
      assert_equal expected, result
    end

    def test_can_find_all_by_item_id
      item_1 = @invoice_item_repository.all[2]
      item_2 = @invoice_item_repository.all[3]
      expected = [item_1, item_2]
      result = @invoice_item_repository.find_all_by_item_id(3)
      assert_equal expected, result
    end

    def test_we_can_find_all_by_invoice_id
      item_1 = @invoice_item_repository.all[2]
      item_2 = @invoice_item_repository.all[3]
      expected = [item_1, item_2]
      result = @invoice_item_repository.find_all_by_invoice_id(3)
      assert_equal expected, result
    end

    def test_we_can_update_an_invoice_item
      @invoice_item_repository.update(1, {quantity: 1000})
      invoice_item = @invoice_item_repository.find_by_id(1)
      assert_equal 1000, invoice_item.quantity
    end

end
