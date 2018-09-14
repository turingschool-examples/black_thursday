
module RepoMethods

def all(objects_array)
  objects_array
end

def create_id
  if last_invoice == nil
    max_id = 1
  else
    max_id = last_invoice.id + 1
  end
end



def find_by_id(id, objects_array)
  findings = objects_array.find_all do |object|
    object.id == id
  end
  findings[0]
end

def find_all_by_merchant_id(merchant_id, objects_array )
  findings = objects_array.find_all do |object|
    object.merchant_id == merchant_id
  end
end

  def delete(id, objects_array, repo)
    object = repo.find_by_id(id)
    if object != nil
      index = objects_array.index(merchant)
      objects_array.delete_at(index)
    else
      puts "object not found"
    end
  end
end
