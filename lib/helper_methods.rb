module HelperMethods

  def find_by_id(id)
    # return all[-1]
    all.find do |line|
      line['id'] == id.to_s
    end['name']
  end

end
