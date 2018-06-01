require_relative 'repository'
require_relative 'transaction'
require 'time'

class TransactionRepository < Repository
  def initialize
    super
  end

  def find_all_by_invoice_id(invoice_id)
    @members.map do |member|
      if member.invoice_id == invoice_id
        member
      end
    end.compact
  end

  def find_all_by_credit_card_number(card_number)
    @members.find_all do |member|
      member.credit_card_number == card_number
    end.compact
  end

  def find_all_by_result(status)
    @members.map do |member|
      if member.result == status.to_sym
        member
      end
    end.compact
  end

  def create(attributes)
    if attributes[:id] == nil
      attributes[:id] = find_next_id
    end
    @members.push(Transaction.new(attributes))
  end

  def update(id, attributes)
    member = find_by_id(id)
    if member != nil
      if attributes[:result] != nil
        member.result = attributes[:result].to_sym
      end
      if attributes[:credit_card_expiration_date] != nil
        member.credit_card_expiration_date = attributes[:credit_card_expiration_date].to_s
      end
      if attributes[:credit_card_number] != nil
        member.credit_card_number = attributes[:credit_card_number]
      end
      member.updated_at = Time.new
    end
    member
  end
end
