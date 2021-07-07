require 'pry'

module Finder
  
  def find_by(repo, id)
    repo.keep_if do |entry|      
      entry.id == id
    end
  end

  


end