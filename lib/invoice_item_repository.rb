require_relative 'repository'
require_relative 'invoice_item'

class InvoiceItemRepository < Repository
  def find_all_by_item_id(item_id)
    @members.map do | member |
      if member.item_id == item_id
        member
      end
    end.compact
  end

  def create(attributes)
    if attributes[:id] == nil
      attributes[:id] = find_next_id
    end
    @members.push(InvoiceItem.new(attributes))
  end
end
