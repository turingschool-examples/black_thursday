require 'csv'
require_relative 'transaction'
require_relative 'repository'

# This class is a repo for transactions
class TransactionRepository
  include Repository
  def initialize(engine = nil)
    @engine = engine
    @elements = {}
  end

  def build_elements_hash(elements)
    elements.each do |element|
      transaction = Transaction.new(element, @engine)
      @elements[transaction.id] = transaction
    end
  end

  def create(attributes)
    create_id_number
    attributes[:id] = create_id_number
    transaction = Transaction.new(attributes, @engine)
    @elements[create_id_number] = transaction
  end

  # def update(id, attributes)
  #   super(id, attributes)
  #   attribute = attributes[:merchant_id]
  #   @elements[id].attributes[:merchant_id] = attribute if attribute
  # end
end
