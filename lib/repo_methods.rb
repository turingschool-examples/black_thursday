
module RepoMethods

  def all
    @objects_array
  end

  def create_id
    if last_invoice == nil
      max_id = 1
    else
      max_id = last_invoice.id + 1
    end
  end

  def find_by_id(id)
    findings = @objects_array.find_all do |object|
      object.id == id
    end
    findings[0]
  end

  def find_all_by_merchant_id(merchant_id, objects_array )
    findings = objects_array.find_all do |object|
      object.merchant_id == merchant_id
    end
  end

  def find_all_by_invoice_id(invoice_id)
    @objects_array.find_all do |object|
      object.invoice_id == invoice_id
    end
  end

  def delete(id)
    findings = @objects_array.find_all do |object|
      object.id == id
    end
    if findings[0] != nil
      @objects_array.delete(findings[0])
    else
      puts "object not found"
    end
  end

  def generate_id
    object = @objects_array.max_by { |object| object.id }
    if object == nil
      object = 1
    else
     object.id + 1
    end
  end
end
