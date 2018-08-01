require_relative 'test_helper'
require_relative '../lib/invoice_item_repo'

class InvoiceItemRepoTest < Minitest::Test

  def setup
    invoice_item_array = [
    {:id=>"21829", :item_id=>"263519844", :invoice_id=>"4984", :quantity=>"10", :unit_price=>"13635", :created_at=>"2000-12-10", :updated_at=>"2011-02-05"}, 
    {:id=>"21830", :item_id=>"263519844", :invoice_id=>"4985", :quantity=>"11", :unit_price=>"13636", :created_at=>"2000-12-10", :updated_at=>"2011-02-05"}, 
    {:id=>"21831", :item_id=>"263519846", :invoice_id=>"4985", :quantity=>"12", :unit_price=>"13637", :created_at=>"2000-12-14", :updated_at=>"2011-02-05"}, 
    {:id=>"21832", :item_id=>"263519847", :invoice_id=>"4987", :quantity=>"13", :unit_price=>"13638", :created_at=>"2000-12-14", :updated_at=>"2011-02-05"}, 
    {:id=>"21833", :item_id=>"263519848", :invoice_id=>"4988", :quantity=>"14", :unit_price=>"13639", :created_at=>"2000-12-14", :updated_at=>"2011-02-05"}, 
    {:id=>"21834", :item_id=>"263519849", :invoice_id=>"4989", :quantity=>"15", :unit_price=>"13630", :created_at=>"2000-12-14", :updated_at=>"2011-02-05"},
    {:id=>"21835", :item_id=>"263519840", :invoice_id=>"4980", :quantity=>"16", :unit_price=>"13631", :created_at=>"2000-12-14", :updated_at=>"2011-02-05"}, 
    {:id=>"21836", :item_id=>"263519841", :invoice_id=>"4981", :quantity=>"17", :unit_price=>"13632", :created_at=>"2000-12-14", :updated_at=>"2011-02-05"}, 
    {:id=>"21837", :item_id=>"263519842", :invoice_id=>"4982", :quantity=>"18", :unit_price=>"13633", :created_at=>"2000-12-14", :updated_at=>"2011-02-05"}, 
    {:id=>"21838", :item_id=>"263519843", :invoice_id=>"4983", :quantity=>"19", :unit_price=>"13634", :created_at=>"2000-12-14", :updated_at=>"2011-02-05"}, 
    {:id=>"21839", :item_id=>"263519839", :invoice_id=>"4990", :quantity=>"20", :unit_price=>"13640", :created_at=>"2000-12-14", :updated_at=>"2011-02-05"}
  ]
    
    @invoice_item_repo = InvoiceItemRepo.new(invoice_item_array)
  end 
  
  def test_it_exists
    assert_instance_of InvoiceItemRepo, @invoice_item_repo
  end
  
  def test_it_returns_all_invoice_items
    assert_equal @invoice_item_repo.invoice_items, @invoice_item_repo.all
  end
  
  def test_it_finds_invoice_item_by_id
    assert_equal @invoice_item_repo.invoice_items[0], @invoice_item_repo.find_by_id(21829)
    assert_equal nil, @invoice_item_repo.find_by_id(1234)
  end
  
  def test_it_finds_all_invoices_items_by_item_id
    assert_equal [@invoice_item_repo.invoice_items[0], @invoice_item_repo.invoice_items[1]], @invoice_item_repo.find_all_by_item_id(263519844)
    assert_equal [], @invoice_item_repo.find_all_by_item_id(1234)
  end
  
  def test_it_finds_all_invoices_items_by_invoice_id
    assert_equal [@invoice_item_repo.invoice_items[1], @invoice_item_repo.invoice_items[2]], @invoice_item_repo.find_all_by_invoice_id(4985)
    assert_equal [], @invoice_item_repo.find_all_by_invoice_id(1234)
  end
    
  def test_it_creates_invoice_item_with_attributes
    refute_instance_of InvoiceItem, @invoice_item_repo.invoice_items[11]
    
    @invoice_item_repo.create({:id         => 6,
                               :item_id    => 7,
                               :invoice_id => 8,
                               :quantity   => 1,
                               :unit_price => BigDecimal.new(10.99,4),
                               :created_at => Time.now,
                               :updated_at => Time.now
                              })
                  
    assert_instance_of InvoiceItem, @invoice_item_repo.invoice_items[11]
  end
  
  def test_it_updates_invoice_item_attributes
    refute_equal 1, @invoice_item_repo.invoice_items[0].quantity 
    refute_equal 10.99, @invoice_item_repo.invoice_items[0].unit_price 
    
    current_time = Time.now.to_s
    
    @invoice_item_repo.update(21829, {:id         => 6,
                                      :item_id    => 7,
                                      :invoice_id => 8,
                                      :quantity   => 1,
                                      :unit_price => BigDecimal.new(10.99,4),
                                      :created_at => Time.now,
                                      :updated_at => current_time
                                    })
                                    
    assert_equal 1, @invoice_item_repo.invoice_items[0].quantity 
    assert_equal 10.99, @invoice_item_repo.invoice_items[0].unit_price 
    assert_equal current_time, @invoice_item_repo.invoice_items[0].updated_at.to_s
  end
  
  def test_it_deletes_invoice_item_by_id
    assert_equal 21829, @invoice_item_repo.invoice_items[0].id
    @invoice_item_repo.delete(21829)
    assert_equal nil, @invoice_item_repo.find_by_id(21829)
  end
  
  
end