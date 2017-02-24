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
    # returns either nil or an instance of Item with a matching ID
  end

  def find_by_name(name_to_search_for)
    collection.each do |id, entry|
      return entry if entry.name.downcase == name_to_search_for.downcase
    end
    nil
    # returns either nil or an instance of Item having done a case insensitive search
  end

  def find_all_by_merchant_id(merchant_id)
    entries_matching_merchant_id = []
    collection.each do |id, entry|
      entries_matching_merchant_id << entry if entry.merchant_id == merchant_id
    end
    entries_matching_merchant_id
    #returns either [] or instances of Item where the supplied merchant ID matches that supplied
  end
end
