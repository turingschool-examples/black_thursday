most_sold_item_for_merchant(merchant_id)

  # get an array of all items for merchant
  # array of invoice id's
  # send over to transaction repo, --> run into invoices_paid_in_full
  # if true, shovel those items into array
  # reach into invoice_items & get highest quantity by item_id

  # array of successful invoices
  # for each successful invoice
  # iterate over successful invoice array
  # make hash of item id's & total quantity
  # hash key with highest value is item
  # get item object from sales engine
