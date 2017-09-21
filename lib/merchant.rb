require_relative 'repository/record'
require_relative 'stats'


class Merchant < Repository::Record

  attr_reader :name
  def initialize(repo, fields)
    super(repo, fields)
    @name = fields[:name]
  end

  def items
    repo.children(:items, id)
  end

  def invoices
    repo.children(:invoices, id)
  end

  def customers
    invoices.map(&:customer).uniq
  end


  def total_revenue
    invoices.reduce(0){ |sum, invoice| sum + invoice.total }
  end

  def average_item_price
    Stats.mean(items, &:unit_price)
  end

  def item_count
    items.length
  end

  def invoice_count
    invoices.length
  end

end
