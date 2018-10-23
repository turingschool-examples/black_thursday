class Repository

  def all
    @collection
  end

  def find_by_id(id)
    found_object = @collection.find do |collection|
      collection.id == id
    end
    found_object
  end

end
