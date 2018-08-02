Failure/Error: expected = sales_analyst.merchants_with_high_item_count
     NoMethodError:
       undefined method `find_all' for nil:NilClass
     # /Users/kellymar/turing/1806BE/paired-projects/black-thursday/black_thursday/lib/sales_analyst.rb:61:in `ids_with_high_item_count'
     # /Users/kellymar/turing/1806BE/paired-projects/black-thursday/black_thursday/lib/sales_analyst.rb:52:in `merchants_with_high_item_count'
     # ./spec/iteration_1_spec.rb:23:in `block (3 levels) in <top (required)>'
#works, but may be an unnecessary step 
def sort_items_by_merchant
  @item_repository.all.sort_by do |item|
    item.merchant_id 
  end  
end