require_relative 'test_helper'
require './lib/sales_engine'
require './lib/invoice_item_repository'

class InvoiceItemRepositoryTest < Minitest::Test
  def setup
    # @ii_1  = InvoiceItem.new({:id => 1, :item_id => 1, :invoice_id => 8, :quantity => 1, :unit_price => BigDecimal.new(1099, 4), :created_at  => '2016-01-11 09:34:06 UTC', :updated_at  => '2007-06-04 21:35:10 UTC'})
    # @ii_2  = InvoiceItem.new({:id => 2, :item_id => 2, :invoice_id => 8, :quantity => 2, :unit_price => BigDecimal.new(1100, 4), :created_at  => '2016-01-11 09:34:06 UTC', :updated_at  => '2007-06-04 21:35:10 UTC'})
    # @ii_3  = InvoiceItem.new({:id => 3, :item_id => 3, :invoice_id => 7, :quantity => 1, :unit_price => BigDecimal.new(1199, 4), :created_at  => '2017-02-12 09:34:06 UTC', :updated_at  => '2007-06-04 21:35:10 UTC'})
    # @ii_4  = InvoiceItem.new({:id => 4, :item_id => 4, :invoice_id => 7, :quantity => 2, :unit_price => BigDecimal.new(1099, 4), :created_at  => '2017-02-12 09:34:06 UTC', :updated_at  => '2007-06-04 21:35:10 UTC'})
    # @ii_5  = InvoiceItem.new({:id => 5, :item_id => 5, :invoice_id => 6, :quantity => 1, :unit_price => BigDecimal.new(1100, 4), :created_at  => '2018-03-13 09:34:06 UTC', :updated_at  => '2007-06-04 21:35:10 UTC'})
    # @ii_6  = InvoiceItem.new({:id => 6, :item_id => 6, :invoice_id => 6, :quantity => 2, :unit_price => BigDecimal.new(1199, 4), :created_at  => '2018-03-13 09:34:06 UTC', :updated_at  => '2007-06-04 21:35:10 UTC'})
    # @ii_7  = InvoiceItem.new({:id => 7, :item_id => 7, :invoice_id => 5, :quantity => 1, :unit_price => BigDecimal.new(1099, 4), :created_at  => '2015-08-18 09:34:06 UTC', :updated_at  => '2007-06-04 21:35:10 UTC'})
    # @ii_8  = InvoiceItem.new({:id => 8, :item_id => 8, :invoice_id => 2, :quantity => 1, :unit_price => BigDecimal.new(1100, 4), :created_at  => '2016-09-19 09:34:06 UTC', :updated_at  => '2007-06-04 21:35:10 UTC'})
    # @ii_9  = InvoiceItem.new({:id => 9, :item_id => 9, :invoice_id => 2, :quantity => 2, :unit_price => BigDecimal.new(1199, 4), :created_at  => '2016-09-19 09:34:06 UTC', :updated_at  => '2007-06-04 21:35:10 UTC'})
    # @ii_10 = InvoiceItem.new({:id => 10, :item_id => 10, :invoice_id => 2, :quantity => 3, :unit_price => BigDecimal.new(1099, 4), :created_at  => '2016-09-19 09:34:06 UTC', :updated_at  => '2007-06-04 21:35:10 UTC'})

    @args = {:invoice_items => "./data/invoice_items.csv"}
    @sales_engine = SalesEngine.from_csv(@args)
    @invoice_items = @sales_engine.invoice_items
  end

  def test_it_exists
    assert_instance_of InvoiceItemRepository, @invoice_items
  end

  def test_invoice_item_repo_holds_all_instances_of_merchants
    skip
    assert_equal 21830, @invoice_items.all.length
  end

  def test_all_returns_array_of_all_merchant_objects
    invoice_items = @invoice_items.all
    assert invoice_items.all? do |invoice_item|
      invoice_item.class == InvoiceItem
    end
  end

  def test_find_by_id_returns_InvoiceItem_with_given_id
    refute @invoice_items.find_by_id('notarealid')
    assert_instance_of InvoiceItem, @invoice_items.find_by_id(30)
    assert_equal 30, @invoice_items.find_by_id(30).id
    assert_equal 263543430, @invoice_items.find_by_id(30).item_id
    assert_equal 6, @invoice_items.find_by_id(30).invoice_id
    assert_equal 6, @invoice_items.find_by_id(30).quantity
    assert_equal 182.22, @invoice_items.find_by_id(30).unit_price
  end

  def test_find_all_by_item_id
    skip
    assert_equal [], @invoice_items.find_all_by_item_id('notarealid')
    assert_instance_of Array, @invoice_items.find_all_by_item_id(263522956)
    assert_equal 19, @invoice_items.find_all_by_item_id(263522956).length
  end

  def test_find_all_by_invoice_id
    skip
    assert_equal [], @invoice_items.find_all_by_invoice_id('notarealid')
    assert_instance_of Array, @invoice_items.find_all_by_invoice_id(6)
    assert_equal 7, @invoice_items.find_all_by_invoice_id(6).length
  end

  def test_it_can_create_a_new_invoice_item_object
    refute @invoice_items.find_by_id(201)
    attributes = {
                  :item_id => 7,
                  :invoice_id => 8,
                  :quantity => 1,
                  :unit_price => BigDecimal.new(10.99, 4),
                  :created_at => Time.now,
                  :updated_at => Time.now
                  }
    @invoice_items.create(attributes)
    assert_equal 201, @invoice_items.find_by_id(201).id
  end

  def test_it_can_update_a_invoice_item
    @invoice_items.create({
                           :item_id => 7,
                           :invoice_id => 8,
                           :quantity => 1,
                           :unit_price => BigDecimal.new(10.99, 4),
                           :created_at => Time.now,
                           :updated_at => Time.now
                           })
    assert @invoice_items.find_by_id(201)
    refute_equal 4, @invoice_items.find_by_id(201).quantity

    @invoice_items.update(201, {
                                :quantity => 4,
                                :unit_price => BigDecimal.new(10.99, 4)
                                })
    assert_equal 4, @invoice_items.find_by_id(201).quantity
    #update(id, attribute) - update the InvoiceItem instance with the corresponding
    #id with the provided attributes. Only the invoice_item’s quantity and unit_price
    #can be updated. This method will also change the invoice_item’s updated_at attribute
    #to the current time.
  end

  def test_it_can_delete_a_merchant_object
    skip
    assert @merchant_repository.find_by_id(12337411)
    @merchant_repository.delete(12337411)
    refute @merchant_repository.find_by_id(12337411)
  end
end
