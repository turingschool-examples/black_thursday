module HelperMethods

  def find_by_id(id)
    result = all.find do |line|
      line['id'] == id.to_s
    end
    return result['name'] unless result == nil
  end

end
