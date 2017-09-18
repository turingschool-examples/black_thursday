def top_merchants_by_invoice_count
  # get the avg # of invoices per merchant (
  make_merchants_and_invoices(invoice)
  average_items_per_merchant


end

def make_merchants_and_invoices(invoice)
  binding.pry
  invoices_array = invoice.all
  merchant_ids = invoice_array.map do |invoice|
    invoice.merchant_id #collects an array of just merchant ids, not the intances.
   end
 invoice_counts = Hash.new 0 #create an empty hash to fill
 merchant_ids.each do |merchant_id| #take the array of plain merchant_ids, and use them to make a key value where we add to the value each time there is another invoices
   invoice_counts[merchant_id] += 1.0
 end
 return invoice_counts #this is a hash of merchant_id => integer (representing how many invoices they have)
end




def average_items_per_merchant
   item_counts = hash_of_merchants_and_number_of_items #method creates a hash of merchant_id => integer(for # of items)
   total_items = item_counts.values.sum #sums array values above
   total_merchants = item_counts.length # returns the # of keys in the hash
   (total_items/total_merchants).round(2) #finds the average of  items per merchant
 end

 def average_items_per_merchant_standard_deviation
   average = average_items_per_merchant #calls method
   individual_minus_average = [] #creates array
   #for following line. shovel results into array. for each hashvalue, #of_items - average # items, which gives us an array of differences then used to calculate the std
   individual_minus_average << hash_of_merchants_and_number_of_items.values.map do |number_of_items|
     number_of_items - average
   end
   individual_minus_average_squared = individual_minus_average.flatten.map {|num| num ** 2}
   std_dev_top = individual_minus_average_squared.sum
   number_of_elements = hash_of_merchants_and_number_of_items.values.count
   Math.sqrt(std_dev_top / (number_of_elements - 1)).round(2)
 end

 def hash_of_merchants_and_number_of_items
   item_array = se.items.all
   merchant_ids = item_array.map do |item|
      item.merchant_id #collects an array of just merchant ids, not the intances.
    end
  item_counts = Hash.new 0
  merchant_ids.each do |merchant_id| #take the array of plain merchant_ids, and use them to make a key value where we add to the value each time there is another invoices
    item_counts[merchant_id] += 1.0
  end
  return item_counts#this is a hash of merchant_id => integer (representing how many invoices they have)
 end

 def std_dev
   average_items_per_merchant_standard_deviation #just creating shorter name to help readability in other calculations.
 end


 def merchants_with_high_item_count
   merchant_ids = []
   item_counts = hash_of_merchants_and_number_of_items #just calling the premade hash
   one_above  = average_items_per_merchant + std_dev
   item_counts.each do |key,value| #using the hash, fill an array with the merchant id (to_i bc it's a key) if the value is more than 1 STD
     merchant_ids << key.to_i if  value > one_above
   end
   merchants = []
   merchant_ids.each do |id| #use the array just created to pass in the id to a merchant method to get a list of MerchantInstances
     merchants << se.merchants.find_by_id(id)
   end
   merchants #returns an arrany of Merchant Instances
 end

 def average_item_price_for_merchant_unrounded(merchant_id)
   total_items = se.items.find_all_by_merchant_id(merchant_id)
   item_prices = total_items.map do |item|
       item.unit_price
     end
   total_item_prices = item_prices.sum
   return 0.00 if total_items.length == 0
   (total_item_prices / total_items.length)
 end

 def average_item_price_for_merchant(merchant_id)
   average_item_price_for_merchant_unrounded(merchant_id).round(2)
 end

 def average_average_price_per_merchant
   average_price_array = se.merchants.all.map do |merchant| #takes all merchant instances and and runs the avg price method using .id
       average_item_price_for_merchant_unrounded(merchant.id)
     end
   sum_averages = average_price_array.sum
   average_average = (sum_averages / se.merchants.all.count) #gets average average
    '%.2f' % average_average
 end
