# sales_analyst.most_sold_item_for_merchant(merchant_id)

  * *One route to obtaining the most sold item(s) for a specified merchant would be use the specified merchant ID by grabbing all of the items associated with that merchant ID. We could then take an array of those items ids and use them as a key in a new Hash. The new hashes values would be made of the item invoice quantities summed together based on those item ids in the hashes keys. We could than grab the max value in that has assigned to its own variable, then use that variable to compare it to each value of the previous hash in a select. That way it will only select all key value pairs that are equal to the highest number value for quantity. The last step would be to return just the keys in the form of an array that has those items ids turned back into the item objects through the find by id method inside of items repository.*

  ```ruby
  def most_sold_item_for_merchant(merchant_id)
    items_array = @engine.items.find_all_by_merchant_id(merchant_id).map do |item|
      item.id # => all of the merchant items [3,4,5]
    end
    items_invoices_hash = {} # => {items => [invoice_items]}
    items_array.each do |item|
      items_invoices_hash[item] = @engine.invoice_items.find_all_by_item_id(item).map do |item_invoice|
        item_invoice.quantity # => {items => [total sum of all quantity]}
      end.sum   # {3=>146, 4=>146, 5=>2}
    end
    max = items_invoices_hash.max_by do |item_id, quantity_total|
      quantity_total # => [3, 146] :: need --- {3=>146, 4=>146}
    end
    new_hash = items_invoices_hash.select do |item_id, quantity_total|
      quantity_total == max[1] # => {3=>146, 4=>146}
    end
    final_output = new_hash.keys.map do |key|
      @engine.items.find_by_id(key) # => [item object , item object]
    end
  end
  ```

#=> item (in terms of revenue generated)
* *We could go about finding the best item for the merchant by merchant id through first finding all invoices that have been paid in full for that merchant. We could then use the invoice id to find the invoices and calculate the invoice with the highest value of quantity multiplied by the unit price of that object, and all instances of that object through each invoice. We could then return the object with the highest of those values.*
