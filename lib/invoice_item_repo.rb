class InvoiceItemRepository

  def initialize(invoice_items_path)
    @all = (
      invoice_items_objects = []
      CSV.foreach(invoice_items_path, headers: true, header_converters: :symbol) do |row|
        invoice_items_objects << InvoiceItem.new(row)
      end
      invoice_items_objects)
  end
end











# Code below is from the Item Repository and needs to begin
# adjusted to be used in this repo


# def create(attributes)
#   new_item = Item.new(attributes)
#   @all << new_item
# end
#
# def update(id, new_name)
#   if find_by_id(id) != nil
#     (find_by_id(id).name.clear.gsub!("", new_name))
#   end
# end
#
# def delete(id)
#   if find_by_id(id) != nil
#     @all.delete(@all.find do |item|
#       merchant.id == id
#     end)
#   end
# end
# end
