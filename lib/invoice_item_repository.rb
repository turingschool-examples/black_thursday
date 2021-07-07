require 'CSV'
require_relative 'repo_module'

class InvoiceItemRepository
  include RepoModule

  attr_reader :repo
  def initialize(file_path)
    @repo = []
    load_items(file_path)
  end

  def load_items(file_path)
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      @repo << InvoiceItem.new(row)
    end
  end

  def find_all_by_item_id(id)
    @repo.find_all do |invoice_item|
      invoice_item.item_id == id
    end
  end

  def find_all_by_invoice_id(id)
    @repo.find_all do |invoice_item|
      invoice_item.invoice_id == id
    end
  end

  def create(attributes)
    attributes[:id] = @repo[-1].id + 1
    @repo << InvoiceItem.new(attributes)
  end

  def update(id, attributes)
    invoice_item = find_by_id(id)
    invoice_item.quantity = attributes[:quantity] unless attributes[:quantity].nil?
    invoice_item.unit_price = attributes[:unit_price] unless attributes[:unit_price].nil?
    invoice_item.updated_at = Time.now unless (attributes[:quantity].nil? && attributes[:unit_price].nil?)
  end


end
