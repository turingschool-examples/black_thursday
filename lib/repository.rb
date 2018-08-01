# frozen_string_literal: true

# ./lib/repository.rb
module Repository
  def find_by_id(id)
    all.find { |each| each.id == id }
  end

  def find_by_name(name)
    all.find { |each| each.name.downcase == name.downcase }
  end

  def delete(id)
    all.delete(find_by_id(id))
  end
end
