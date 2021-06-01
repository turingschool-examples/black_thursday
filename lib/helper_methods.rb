module HelperMethods

  def find_by_id(id)
    result = all.find do |line|
      line['id'] == id.to_s
    end
    return result unless result == nil
  end

  def find_by_name(name)
    result = all.find do |line|
      line['name'].downcase == name.to_s.downcase
    end
    return result unless result == nil
  end

  def find_all_by_name(name_frag)
    result = all.select do |line|
      line['name'].downcase.include?(name_frag.downcase)
    end
    return result
  end

  def create_new_id
    result = all.max_by do |line|
      line['id'].to_i
    end
    result['id'].to_i + 1
  end

end
