module Findable

  def find_by_id(id)
    @all.find do |object|
      object.id == id
    end
  end

end
