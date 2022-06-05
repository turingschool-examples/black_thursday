require 'entry'
class Transaction
  attr_reader :id, :invoice_id, :created_at

  attr_accessor :credit_card_number,
                :credit_card_expiration_date,
                :result,
                :updated_at

  def initialize(details)
    @id = details[:id]
    @invoice_id = details[:invoice_id]
    @credit_card_number = details[:credit_card_number]
    @credit_card_expiration_date = details[:credit_card_expiration_date]
    @result = details[:result]
    @created_at = details[:created_at]
    @updated_at = details[:updated_at]
  end



  # def find_by_id(id)
  #   @all.find do |invoice_item|
  #     invoice_item.id == id
  #   end
  # end
  #
  # def find_all_by_item_id(item_id)
  #   @all.find_all do |invoice_item|
  #     invoice_item.item_id.to_i == item_id.to_i
  #   end
  # end
  #
  # def find_all_by_invoice_id(item_id)
  #   @all.find_all do |invoice_item|
  #     invoice_item.invoice_id.to_i == invoice_id.to_i
  #   end
  # end
  #
  # def create(attributes)
  #   x = (@all.last.id + 1)
  #   @all << InvoiceItem.new({
  #     :id => x,
  #     :item_id => attributes[:item_id],
  #     :invoice_id => attributes[:invoice_id],
  #     :quantity => attributes[:quantity],
  #     :unit_price => attributes[:unit_price],
  #     :created_at => attributes[:created_at],
  #     :updated_at => attributes[:updated_at]
  #     })
  # end
  #
  # def update(id, attributes)
  #   x = find_by_id(id)
  #   x.quantity = attributes[:quantity]
  #   x.unit_price = attributes[:unit_price]
  #   x.updated_at = Time.now
  # end
  #
  # def delete(id)
  #   x = find_by_id(id)
  #   @all.delete(x)
  # end

end
