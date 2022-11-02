# frozen_string_literal: true

# This is the transaction class
class Transaction
  def initialize(stats)
    @stats = stats
  end

  def id
    @stats[:id]
  end

  def invoice_id
    @stats[:invoice_id]
  end

  def credit_card_number
    @stats[:credit_card_number]
  end

  def credit_card_expiration_date
    @stats[:credit_card_expiration_date]
  end

  def result
    @stats[:result]
  end

  def created_at
    @stats[:created_at]
  end

  def updated_at
    @stats[:updated_at]
  end

  def update(attributes)
    @stats[:credit_card_number] = attributes[:credit_card_number] unless attributes[:credit_card_number].nil?
    @stats[:credit_card_expiration_date] = attributes[:credit_card_expiration_date] unless attributes[:credit_card_expiration_date].nil?
    @stats[:result] = attributes[:result] unless attributes[:result].nil?
    @stats[:updated_at] = Time.now
  end
end
