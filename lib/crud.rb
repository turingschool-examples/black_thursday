require 'pry'
require_relative 'finderclass'

module CRUD

  def make_id(repo, method)
    FinderClass.find_max(repo, method).id + 1
  end


  def update_entry(repo, id, attributes)
    entry = FinderClass.find_by(repo, :id, id)
    current_time = "2007-06-04 21:35:10 UTC" #Time.now
    
    entry.name = attributes[:name] if attributes[:name]
    entry.description = attributes[:description] if attributes[:description]
    entry.unit_price = attributes[:unit_price] if attributes[:unit_price]
    entry.updated_at = current_time if attributes[:current_time]
    entry.status = attributes[:status] if attributes[:status]
    entry.quantity = attributes[:quantity] if attributes[:quantity]
    entry.item_id = attributes[:item_id] if attributes[:item_id]

  end


  def delete_entry(repo, id)
    entry = FinderClass.find_by(repo, :id, id)
    repo.delete(entry)
  end

end