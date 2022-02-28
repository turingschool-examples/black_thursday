module Findable
  def find_by_name(name)
    @all.find do |one|
      one.name.downcase == name.downcase
    end
  end

  def find_by_id(id)
    @all.find do |one|
      one.id == id
    end
  end
end
