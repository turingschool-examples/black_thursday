module Find

  #hash is {:field => search_term}
  def find_by(search_hash)
    # all.each do |instance|
    #if instance.send(search_hash.keys[0]) == search_term
    #return instance
  end

  #works for strings only
  def find_all_by_fragment(search_hash)
    #matches = []
    # all.each do |instance|
    #if instance.send(search_hash.keys[0]).downcase.include?( search_term.downcase)
    # add instance to matches
    #return matches
  end

  #works for strings only
  def find_all_by_full(search_hash)
    #matches = []
    # all.each do |instance|
    #if instance.send(search_hash.keys[0]).downcase == search_term.downcase
    # add instance to matches
    #return matches
  end


end
