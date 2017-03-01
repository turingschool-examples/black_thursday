# UPDATE METHODS FROM CLASSES BEFORE MOVING TO FILE
#
#
# module Relationships
#
# # methods in Merchant class
#   def items
#     parent.engine.items.find_all_by_merchant_id(id)
#   end
#
#   def invoices
#     parent.engine.invoices.find_all_by_merchant_id(id)
#   end
#
# # methods in Item class
#   def merchant
#     parent.engine.merchant.find_by_id(merchant_id)
#   end
#
# # methods in Invoice class
#   def merchant
#     parent.engine.merchant.find_by_id(merchant_id)
#   end
#
#   def items
#     parent.engine.invoice_items.find_all_by_item_id(item_id)
#   end
#
#   def transactions
#     parent.engine.transactions.find_all_y_invoice_id(invoice_id)
#   end
#
#   def customer
#     parent.engine.customer.find_by_id(id)
#   end
#
# # methods in Transaction class
#   def invoice
#     parent.engine.invoice.find_by_id(invoinvoice_id)
#   end
#
# # methods in Customer class
#   def merchants
#     parent.engine.invoices.find_all_by_merchant_id(merchant_id)
#   end
