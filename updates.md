Finished:
*all - returns an array of all known Item instances
*find_by_id(id) - returns either nil or an instance of Item with a matching ID
*find_by_name(name) - returns either nil or an instance of Item having done a case insensitive search
*delete(id) - delete the Item instance with the corresponding id
 *find_all_with_description(description) - returns either [] or instances of Item where the supplied string appears in the item description (case insensitive)

Update:
*find_all_by_price(price) - returns either [] or instances of Item where the supplied price exactly matches

Pending:
 *find_all_by_price_in_range(range) - returns either [] or instances of Item where the supplied price is in the supplied range (a single Ruby range instance is passed in)
 *find_all_by_merchant_id(merchant_id) - returns either [] or instances of Item where the supplied merchant ID matches that supplied
 *create(attributes) - create a new Item instance with the provided attributes. The new Item’s id should be the current highest Item id plus 1.
 *update(id, attributes) - update the Item instance with the corresponding id with the provided attributes. Only the item’s name, desription, and unit_price attributes can be updated. This method will also change the items updated_at attribute to the current time.
