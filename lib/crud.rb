require 'pry'
require_relative 'finderclass'

module CRUD

  def make_id(repo, method)
    FinderClass.find_max(repo, method).id + 1
  end


  def update(repo, id, attributes)
    entry = repo.find_by_id(id)
    current_time = "2007-06-04 21:35:10 UTC" #Time.now
    
    entry.name = attributes[:name] if attributes[:name]
    entry.description = attributes[:description] if attributes[:description]
    entry.unit_price = attributes[:unit_price] if attributes[:unit_price]
    entry.updated_at = current_time if attributes{:current_time}
  end


  def delete(repo, id)
    entry = repo.find_by_id(id)
    repo -= [entry]
  end

end