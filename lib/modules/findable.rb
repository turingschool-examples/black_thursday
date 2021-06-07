module Findable

  def find_by_id(id)
    @all.find do |object|
      object.id == id
    end
  end

  def find_by_name(name)
    @all.find do |object|
      object.name.downcase.include?(name.downcase)
    end
  end
end
