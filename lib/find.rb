module Find

  #hash is {:field => search_term}
  def find_by(search_hash)
    # all.find do |instance|
      #if instance.send(search_hash.keys[0]) == search_term
  end

  #works for strings only
  def find_all_by_fragment(search_hash)
    # all.find_all do |instance|
      #instance.send(search_hash.keys[0]).downcase.include?( search_term.downcase)
  end

  #works for strings only
  def find_all_by_full(search_hash)
    # all.find_all do |instance|
    #if instance.send(search_hash.keys[0]).downcase == search_term.downcase
  end


end
