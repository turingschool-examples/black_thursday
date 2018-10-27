require './test/test_helper'

class InvoiceRepositoryTest < Minitest::Test

  def setup
    ir = InvoiceRepository.new('./data/invoice_test_data.csv')
  end

  def test_it_exists
    assert_instance_of InvoiceRepository, ir
  end

  def test_it_can_create_repository_array
    skip
    #this test ignores the setup array
    assert_instance_of Array, ir.create_repo_array('./data/invoice_test_data.csv')
  end

  def test_invoice_repo_has_repository array
    skip
    assert_equal 25, ir.all.count
  end

  def test_find_by_id
    skip
    item = ir.repo_array[1]
    assert_equal item, ir.find_by_id(263397059)
  end

  def test_find_all_by_customer_id
    skip
    assert_instance_of Item, ir.find_by_name('Etre ailleurs')
  end

  def test_it_can_find_all_by_merchant_id
    skip
    item = ir.repo_array[0]
    assert_instance_of Item, ir.find_all_by_merchant_id(12334141).first
    assert_equal [item], ir.find_all_by_merchant_id(12334141)
  end

  def test_it_can_find_all_by_status
    skip
    assert_equal [], ir.find_all_with_description('Disney glitter frames')
  end

  def test_it_can_find_max_id_and_increase_it_by_one
    skip
    assert_equal 263398204, ir.new_highest_id
  end

  def test_we_can_create_new_invoice_and_increment_its_id_up_one
    skip
    new_item = ir.create({:name => 'New_Item'})
    assert_equal 'New_Item', new_item.name
    assert_equal 263398204, new_item.id
  end

  def test_we_can_update_attributes
    skip

    ir.create({:name => 'Shoes', :description => 'very comfy', :unit_price => 2000})
    ir.update(263398203, {:name => 'Shiny Shoes', :description => 'even more comfy', :unit_price => 3500})
    updated_item = ir.find_by_id(263398203)
    assert_equal 'Shiny Shoes', updated_item.name
    assert_equal 'even more comfy', updated_item.description
    assert_equal 3500, updated_item.unit_price
  end

  def test_it_can_delete_by_id
    skip
    ir.delete(263397059)
    assert_equal nil, ir.find_by_id(263397059)
  end

end
