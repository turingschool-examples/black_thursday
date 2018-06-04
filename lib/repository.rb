class Repository
  attr_reader   :members

  def initialize
    @members = []
  end

  def find_next_id
    id = 0
    @members.each do | member |
      if member.id > id
        id = member.id
      end
    end
    return id + 1
  end

  def all
    return @members
  end

  def find_by_id(id)
    @members.each do |member|
      if member.id == id
        return member
      end
    end
    nil
  end

  def find_by_name(name)
    @members.each do |member|
      if member.name.downcase == name.downcase
        return member
      end
    end
    nil
  end

  def find_all_by_invoice_id(invoice_id)
    @members.map do |member|
      if member.invoice_id == invoice_id
        member
      end
    end.compact
  end

  def find_all_by_merchant_id(merchant_id)
    @members.map do | invoice |
      if invoice.merchant_id == merchant_id
        invoice
      end
    end.compact
  end

  def update(id, attributes)
    member = find_by_id(id)
    if member != nil
      if attributes[:name] != nil
        member.name = attributes[:name]
      end
      if attributes[:result] != nil
        member.result = attributes[:result].to_sym
      end
      if attributes[:credit_card_expiration_date] != nil
        member.credit_card_expiration_date = attributes[:credit_card_expiration_date].to_s
      end
      if attributes[:credit_card_number] != nil
        member.credit_card_number = attributes[:credit_card_number]
      end
      if attributes[:description] != nil
        member.description = attributes[:description]
      end
      if attributes[:unit_price] != nil
        member.unit_price = attributes[:unit_price]
      end
      if attributes[:status] != nil
        member.status = attributes[:status].to_sym
      end
      if attributes[:quantity] != nil
        member.quantity = attributes[:quantity]
      end
      if attributes[:first_name] != nil
        member.first_name = attributes[:first_name]
      end
      if attributes[:last_name] != nil
        member.last_name = attributes[:last_name]
      end
      if member.class != Merchant
        member.updated_at = Time.new
      end
    end
  end

  def delete(id)
    i = nil
    @members.each_with_index do | member, index |
      if member.id == id
        i = index
      end
    end
    if i !=nil
      @members.delete_at(i)
    end
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end
