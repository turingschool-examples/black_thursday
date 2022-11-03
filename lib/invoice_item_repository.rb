require_relative 'reposable'
require_relative './item'

class InvoiceItemRepository
  include Reposable

  attr_accessor :all

  def initialize(all = [])
    @all = all
  end
end