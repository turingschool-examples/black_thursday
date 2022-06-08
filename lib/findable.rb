require_relative 'helper'

module Findable
  def is_digit?(input)
    code = input.ord
    48 <= code && code <= 57
  end

  def find_by_id(id_number)
    @all.find {|thing| thing.id == id_number}
  end

  def find_by_name(name)
    @all.find {|thing| thing.name.downcase == name.downcase.strip}
  end

  def find_all_by_name(input)
    @all.select do |thing|
      pieces = thing.name.chars.map do |piece|
        is_digit?(piece) ? piece : piece.downcase
      end
      array = pieces.join('')
      array.include?(input)
    end
  end

  def find_all_by_merchant_id(id_number)
    @all.select {|thing| thing.merchant_id == id_number}
  end

  def find_all_by_customer_id(id_number)
    @all.select {|invoice_item| invoice_item.customer_id == id_number}
  end

  def find_all_by_item_id(id_number)
    @all.select {|invoice_item| invoice_item.item_id == id_number}
  end

  def find_all_by_invoice_id(id_number)
    @all.select {|invoice| invoice.invoice_id == id_number}
  end

  def find_all_by_status(status)
    @all.select {|invoice| invoice.status == status}
  end

  def find_all_by_result(result)
    @all.select {|transaction| transaction.result == result}
  end

  def find_all_by_credit_card_number(number)
    @all.select {|transaction| transaction.credit_card_number == number}
  end

  def find_all_with_description(input)
    @all.select {|item| item.name.downcase.include?(input.downcase.strip)}
  end

  def find_all_by_price(input)
    @all.select {|item| item.unit_price_to_dollars == input.to_f}
  end

  def find_all_by_price_in_range(low_end,high_end)
    @all.select {|item| item.unit_price_to_dollars >= low_end.to_f && item.unit_price_to_dollars <= high_end.to_f}
  end

  def find_all_by_transaction_date(date)
    @all.select {|invoice| invoice.created_at == date}
  end
end
