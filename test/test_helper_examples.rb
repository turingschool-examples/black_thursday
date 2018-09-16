
# Create Examples via all data for use in tests

require_relative '../lib/merchant'
require_relative '../lib/item'
require_relative '../lib/customer'
require_relative '../lib/invoice'
require_relative '../lib/invoice_item'
require_relative '../lib/transaction'


# ===== Merchant Examples =================
# id,name,created_at,updated_at
      # 12334105,Shopin1901,2010-12-10,2011-12-04
      # 12334112,Candisart,2009-05-30,2010-08-29
@merch_1_hash = { :"12334105" => { name: "Shopin1901", created_at: "2010-12-10", updated_at: "2011-12-04" } }
@merch_2_hash = { :"12334112" => { name: "Candisart",  created_at: "2009-05-30", updated_at: "2010-08-29" } }
@merch_1 = Merchant.new(@merch_1_hash)
@merch_2 = Merchant.new(@merch_2_hash)


# ===== Item Examples =================
# id,name,description,unit_price,merchant_id,created_at,updated_at
      # 263395237,510+ RealPush Icon Set,"You&#39;ve got a total socialmedia iconset! # 1200,12334141,2016-01-11 09:34:06 UTC,2007-06-04 21:35:10 UTC
      # 263395617,Glitter scrabble frames,"Glitter scrabble frames # ,1300,12334185,2016-01-11 11:51:37 UTC,1993-09-29 11:56:40 UTC

@item_1_hash = { :"263395237" => { name:        "510+ RealPush Icon Set",
                                   description: "You&#39;ve got a total socialmedia iconset!", # Excerpt!
                                   unit_price:  "1200",
                                   merchant_id: "12334141",
                                   created_at:  "2016-01-11 09:34:06 UTC",
                                   updated_at:  "2007-06-04 21:35:10 UTC"
                                  } }
@item_1_hash = { :"263395617" => { name:        "Glitter scrabble frames",
                                   description: "Glitter scrabble frames", # Excerpt!
                                   unit_price:  "1300",
                                   merchant_id: "12334185",
                                   created_at:  "2016-01-11 11:51:37 UTC",
                                   updated_at:  "1993-09-29 11:56:40 UTC"
                                  } }
@item_1 = Item.new(@item_1_hash)
@item_2 = Item.new(@item_2_hash)


# ===== Invoice Examples =================
# id,customer_id,merchant_id,status,created_at,updated_at
      # 1,1,12335938,pending,2009-02-07,2014-03-15
      # 2,1,12334753,shipped,2012-11-23,2013-04-14
@invoice_1_hash = { "1" => { customer_id: "1",
                             merchant_id: "12335938",
                             status:      "pending",
                             created_at:  "2009-02-07",
                             updated_at:  "2014-03-15"
                            } }
@invoice_2_hash = { "2" => { customer_id: "1",
                             merchant_id: "12334753",
                             status:      "shipped",
                             created_at:  "2012-11-23",
                             updated_at:  "2013-04-14"
                            } }
@invoice_1 = Invoice.new(@invoice_1_hash)
@invoice_2 = Invoice.new(@invoice_2_hash)


# ===== Invoice Item Examples =================
# id,item_id,invoice_id,quantity,unit_price,created_at,updated_at
      # 1,263519844,1,5,13635,2012-03-27 14:54:09 UTC,2012-03-27 14:54:09 UTC
          # 2,263454779,1,9,23324,2012-03-27 14:54:09 UTC,2012-03-27 14:54:09 UTC
          # 3,263451719,1,8,34873,2012-03-27 14:54:09 UTC,2012-03-27 14:54:09 UTC
          # 4,263542298,1,3,2196,2012-03-27 14:54:09 UTC,2012-03-27 14:54:09 UTC
          # 5,263515158,1,7,79140,2012-03-27 14:54:09 UTC,2012-03-27 14:54:09 UTC
          # 6,263539664,1,5,52100,2012-03-27 14:54:09 UTC,2012-03-27 14:54:09 UTC
          # 7,263563764,1,4,66747,2012-03-27 14:54:09 UTC,2012-03-27 14:54:09 UTC
          # 8,263432817,1,6,76941,2012-03-27 14:54:09 UTC,2012-03-27 14:54:09 UTC
      # 9,263529264,2,6,29973,2012-03-27 14:54:09 UTC,2012-03-27 14:54:09 UTC
          # 10,263523644,2,4,1859,2012-03-27 14:54:09 UTC,2012-03-27 14:54:09 UTC
          # 11,263532898,2,3,30949,2012-03-27 14:54:09 UTC,2012-03-27 14:54:09 UTC
          # 12,263438971,2,8,31099,2012-03-27 14:54:09 UTC,2012-03-27 14:54:09 UTC

@invoice_item_1_hash = { :"1" => { item_id:    "263519844",
                                   invoice_id: "1",
                                   quantity:   "5",
                                   unit_price: "13635",
                                   created_at: "2012-03-27 14:54:09 UTC",
                                   updated_at: "2012-03-27 14:54:09 UTC"
                                  } }
@invoice_item_9_hash = { :"9" => { item_id:    "263529264",
                                   invoice_id: "2",
                                   quantity:   "6",
                                   unit_price: "29973",
                                   created_at: "2012-03-27 14:54:09 UTC",
                                   updated_at: "2012-03-27 14:54:09 UTC"
                                  } }
@invoice_item_1 = InvoiceItem.new(@invoice_item_1_hash)
@invoice_item_9 = InvoiceItem.new(@invoice_item_9_hash)


# # ===== Transaction Examples =================
# id,invoice_id,credit_card_number,credit_card_expiration_date,result,created_at,updated_at
# 1,2179,4068631943231473,0217,success,2012-02-26 20:56:56 UTC,2012-02-26 20:56:56 UTC
# 2,46,4177816490204479,0813,success,2012-02-26 20:56:56 UTC,2012-02-26 20:56:56 UTC
@transaction_1_hash = { :"1" => { invocie_id:         "2179",
                                  credit_card_number: "4068631943231473",
                                  credit_card_expiration_date: "0217",
                                  result:             "success",
                                  created_at:         "2012-02-26 20:56:56 UTC",
                                  updated_at:         "2012-02-26 20:56:56 UTC"
                                 } }
@transaction_2_hash = { :"2" => { invocie_id:         "46",
                                  credit_card_number: "4177816490204479",
                                  credit_card_expiration_date: "0813",
                                  result:                      "success",
                                  created_at:         "2012-02-26 20:56:56 UTC",
                                  updated_at:         "2012-02-26 20:56:56 UTC"
                                 } }
@transaction_1 = Transaction.new(@transaction_1_hash)
@transaction_2 = Transaction.new(@transaction_2_hash)

# ===== Customer Examples =================
# id,first_name,last_name,created_at,updated_at
# 1,Joey,Ondricka,2012-03-27 14:54:09 UTC,2012-03-27 14:54:09 UTC
# 2,Cecelia,Osinski,2012-03-27 14:54:10 UTC,2012-03-27 14:54:10 UTC
@customer_1_hash = { :"1" => { first_name: "Joey",
                               last_name:  "Ondricka",
                               created_at: "2012-03-27 14:54:09 UTC",
                               updated_at: "2012-03-27 14:54:09 UTC"
                              } }
@customer_2_hash = { :"2" => { first_name: "Cecelia",
                               last_name:  "Osinski",
                               created_at: "2012-03-27 14:54:10 UTC",
                               updated_at: "2012-03-27 14:54:10 UTC"
                              } }
