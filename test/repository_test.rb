


# - all - returns an array of all known Merchant instances
# - find_by_id(id) - returns either nil or an instance of Merchant with a matching ID
# - find_by_name(name) - returns either nil or an instance of Merchant having done a case insensitive search
#
# - find_all_by_name(name) - returns either [] or one or more matches which contain the supplied name fragment, case insensitive
# - create(attributes) - create a new Merchant instance with the provided attributes. The new Merchant’s id should be the current highest Merchant id plus 1.
# - delete(id) - delete the Merchant instance with the corresponding id

#slightly unique
# - update(id, attributes) - update the Merchant instance with the corresponding id with the provided attributes. Only the merchant’s name attribute can be updated.
