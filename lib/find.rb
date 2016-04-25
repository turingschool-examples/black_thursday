module Find

  #search_hash format is like: {:id => 23}

  def find_by_num(search_hash)
    all.find do |instance|
      instance.send(search_hash.keys[0]) == search_hash.values[0]
    end
  end

  def find_all_by_num(search_hash)
    all.find_all do |instance|
      instance.send(search_hash.keys[0]) == search_hash.values[0]
    end
  end

  def find_by_string(search_hash)
    all.find do |instance|
      instance.send(search_hash.keys[0]).downcase ==
      search_hash.values[0].downcase
    end
  end

  def find_all_by_string_fragment(search_hash)
    all.find_all do |instance|
      instance.send(search_hash.keys[0]).downcase.
          include?(search_hash.values[0].downcase)
    end
  end

  def find_all_by_string_full(search_hash)
    all.find_all do |instance|
      instance.send(search_hash.keys[0]).downcase ==
      search_hash.values[0].downcase
    end
  end

  def inspect
    "#<\#{self.class} \#{all.size} rows>"
  end

end
