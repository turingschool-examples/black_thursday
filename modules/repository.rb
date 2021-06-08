module Repository
  
  def find_by_id(id)
    return nil unless
    @all.find_all do |thing|
      if thing.id == id
        return thing
      end
    end
  end

end
