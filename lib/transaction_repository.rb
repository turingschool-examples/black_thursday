require_relative 'repo_methods'
require_relative 'transaction'

class TransactionRepository
  include RepoMethods
  attr_reader :collection

  def initialize(data_from_csv)
    @collection = get_data_from_csv(data_from_csv)
  end

  def get_data_from_csv(data_from_csv)
    data_from_csv.map do |line|
      [line[:id].to_i, Transaction.new(line)]
    end.to_h
  end

  def find_all_by_credit_card_number(credit_card_number)
    all.find_all do |transaction|
      transaction.credit_card_number == credit_card_number
    end
  end

  def find_all_by_result(result)
    all.find_all do |transaction|
      transaction.result == result
    end
  end

  def create(attributes)
    attributes[:id] = new_id
    @collection[new_id] = Transaction.new(attributes)
  end

  def update(current_id, new_attributes)
    if @collection[current_id] == nil
    else
      @collection[current_id].update_result(new_attributes) if new_attributes[:result]
      @collection[current_id].update_credit_card_number(new_attributes) if new_attributes[:credit_card_number]
      @collection[current_id].update_credit_card_expiration_date(new_attributes) if new_attributes[:credit_card_expiration_date]
      @collection[current_id].update_updated_at(Time.now)
    end
  end

  # def result_table
  #   all.map do |transaction|
  #     [transaction.invoice_id, transaction.result]
  #   end.to_h
  # end


end
