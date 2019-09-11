require_relative 'repository'
require_relative 'transaction'

class TransactionRepository < Repository
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
end
