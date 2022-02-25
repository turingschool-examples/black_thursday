module Findable
  def find_by_id(id_num)
    index = @all.rindex { |object| object.id == id_num }
    return @all[index]
  end

  def find_by_name(name)
    @all.find { |object| object.name.downcase == name.downcase }
  end
end
