require_relative '../lib/invoice_item_repository'
require_relative 'spec_helper'
require          'pry'
require          'minitest/autorun'
require          'minitest/pride'


class InvoiceItemRepositoryTest < Minitest::Test
  attr_reader :repo

  def test_class_exist
    assert InvoiceItemRepository
  end

  def setup
    @repo = InvoiceItemRepository.new([
     {:id=>"1", :item_id=>"1111", :invoice_id=>"1", :quantity=>"5", :unit_price=>"13635", :created_at=>"2012-03-27 14:54:09 UTC", :updated_at=>"2012-03-27 14:54:09 UTC"},
     {:id=>"2", :item_id=>"2222", :invoice_id=>"2", :quantity=>"9", :unit_price=>"23324", :created_at=>"2012-03-27 14:54:09 UTC", :updated_at=>"2012-03-27 14:54:09 UTC"},
     {:id=>"3", :item_id=>"3333", :invoice_id=>"3", :quantity=>"8", :unit_price=>"34873", :created_at=>"2012-03-27 14:54:09 UTC", :updated_at=>"2012-03-27 14:54:09 UTC"},
     {:id=>"4", :item_id=>"4444", :invoice_id=>"4", :quantity=>"3", :unit_price=>"2196", :created_at=>"2012-03-27 14:54:09 UTC", :updated_at=>"2012-03-27 14:54:09 UTC"},
     {:id=>"5", :item_id=>"5555", :invoice_id=>"5", :quantity=>"7", :unit_price=>"79140", :created_at=>"2012-03-27 14:54:09 UTC", :updated_at=>"2012-03-27 14:54:09 UTC"},
     {:id=>"6", :item_id=>"6666", :invoice_id=>"6", :quantity=>"5", :unit_price=>"52100", :created_at=>"2012-03-27 14:54:09 UTC", :updated_at=>"2012-03-27 14:54:09 UTC"},
     {:id=>"7", :item_id=>"7777", :invoice_id=>"7", :quantity=>"4", :unit_price=>"66747", :created_at=>"2012-03-27 14:54:09 UTC", :updated_at=>"2012-03-27 14:54:09 UTC"},
     {:id=>"8", :item_id=>"8888", :invoice_id=>"8", :quantity=>"6", :unit_price=>"76941", :created_at=>"2012-03-27 14:54:09 UTC", :updated_at=>"2012-03-27 14:54:09 UTC"},
     {:id=>"9", :item_id=>"9999", :invoice_id=>"9", :quantity=>"6", :unit_price=>"29973", :created_at=>"2012-03-27 14:54:09 UTC", :updated_at=>"2012-03-27 14:54:09 UTC"},
     {:id=>"10", :item_id=>"9999", :invoice_id=>"10", :quantity=>"4", :unit_price=>"1859", :created_at=>"2012-03-27 14:54:09 UTC", :updated_at=>"2012-03-27 14:54:09 UTC"}])
  end





end
