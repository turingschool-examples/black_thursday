# Transactions are billing records for an invoice. An invoice can have multiple transactions, but should have at most one that is successful.
# 
# The TransactionRepository is responsible for holding and searching our Transaction instances. It offers the following methods:
#
# all - returns an array of all known Transaction instances
# find_by_id - returns either nil or an instance of Transaction with a matching ID
# find_all_by_invoice_id - returns either [] or one or more matches which have a matching invoice ID
# find_all_by_credit_card_number - returns either [] or one or more matches which have a matching credit card number
# find_all_by_result - returns either [] or one or more matches which have a matching status
# create(attributes) - create a new Transaction instance with the provided attributes. The new Transaction’s id should be the current highest Transaction id plus 1.
# update(id, attribute) - update the Transaction instance with the corresponding id with the provided attributes. Only the transaction’s credit_card_number, credit_card_expiration_date, and result can be updated. This method will also change the transaction’s updated_at attribute to the current time.
# delete(id) - delete the Transaction instance with the corresponding id
# The data can be found in data/transactions.csv so the instance is created and used like this:
#
# sales_engine = SalesEngine.from_csv(:transactions => "./data/transactions.csv")
# transaction = sales_engine.transactions.find_by_id(6)
# # => <Transaction>
