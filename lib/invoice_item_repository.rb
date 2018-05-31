require_relative 'repository'
require_relative 'invoice_item'

class InvoiceItemRepository < Repository

  def initialize
    super
  end

  def find_all_by_item_id(item_id)
    @members.map do | member |
      if member.item_id == item_id
        member
      end
    end.compact
  end

  def find_all_by_invoice_id(invoice_id)
    @members.map do | member |
      if member.invoice_id == invoice_id
        member
      end
    end.compact
  end

  def update(id, attributes)
    member = find_by_id(id)
    if member != nil
      if attributes[:quantity] != nil
        member.quantity = attributes[:quantity]
      end
      if attributes[:unit_price] != nil
        member.unit_price = attributes[:unit_price]
      end
      member.updated_at = Time.new
    end

  end

  def create(attributes)
    if attributes[:id] == nil
      attributes[:id] = find_next_id
    end
    @members.push(InvoiceItem.new(attributes))
  end
end
