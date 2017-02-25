module RepositoryMethods
  def populate_repository(path)
    data = CSV.read(path, headers: true, header_converters: :symbol)
    data.each do |row|
      collection[row[:id].to_sym] = child.new(row)
    end
  end

  def all
    collection.map do |id, entry|
      entry
    end
  end

  def find_by_id(id)
    collection[id.to_s.to_sym]
  end

  def find_by_name(name_to_search_for)
    collection.each do |id, entry|
      return entry if entry.name.downcase == name_to_search_for.downcase
    end
    nil
  end

  def find_all_by_name(name_fragment)

    collection.reduce([]) do |all_matches, (id, entry)|
      all_matches << entry if entry.name.downcase.include?(name_fragment.downcase)
      all_matches
    end
  end

  def find_all_by_merchant_id(merchant_id)
    entries_matching_merchant_id = []
    collection.each do |id, entry|
      entries_matching_merchant_id << entry if entry.merchant_id == merchant_id
    end
    entries_matching_merchant_id
  end
end
