require 'bigdecimal'
require 'time'
class Transaction
  attr_reader   :id,
                :invoice_id,
                :created_at

  attr_accessor :credit_card_number,
                :credit_card_expiration_date,
                :result,
                :updated_at

  @@highest_item_id = 0

  def initialize(attributes)
    @id = attributes[:id].to_i
    @invoice_id = attributes[:invoice_id].to_i
    @credit_card_number = attributes[:credit_card_number]
    @credit_card_expiration_date = attributes[:credit_card_expiration_date]
    @result = attributes[:result].to_sym
    @created_at = Time.parse(attributes[:created_at])
    @updated_at = Time.parse(attributes[:updated_at])
    highest_id_updater
  end

  def highest_id_updater
    @@highest_item_id = @id if @id > @@highest_item_id
  end

  def self.create(attributes)
    item_id = @@highest_item_id += 1
    new(id: item_id,
        invoice_id: attributes[:invoice_id],
        credit_card_number: attributes[:credit_card_number],
        credit_card_expiration_date: attributes[:credit_card_expiration_date],
        result: attributes[:result].to_sym,
        created_at: attributes[:created_at].to_s,
        updated_at: attributes[:updated_at].to_s)
  end

end
