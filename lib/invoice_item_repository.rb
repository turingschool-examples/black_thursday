require_relative '../lib/modules/repo_queries'

class InvoiceItemRepository
  include RepoQueries

  attr_reader :data, :engine

  def initialize(file = nil, engine = nil)
    @data = []
    @engine = engine
    @child = InvoiceItem
    load_data(file)
  end

  def find_all_by_item_id(item_id)
    all.find_all do |datum|
      datum.item_id == item_id
    end
  end
end
