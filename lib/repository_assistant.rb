module RepositoryAssistant

  def all
    @repository.find_all do |repo_object|
      repo_object
    end
  end

  def find_by_name(name)
    @repository.find do |repo_object|
      repo_object.name.downcase == name.downcase
    end
  end

  def find_by_id(id)
    @repository.find do |repo_object|
      repo_object.id == id
    end
  end


  def find_all_by_invoice_id(id)
    @repository.find_all do |repo_object|
      repo_object.invoice_id == id
    end
  end

  def delete(id)
    found_id = find_by_id(id)
    @repository.delete(found_id)
  end

  def create_new_id_number
    max_id = @repository.max_by(&:id).id
    new_id = max_id + 1
  end

  def update(id, attributes)
    repo_object = find_by_id(id)
    return if repo_object.nil?
    # update_mehotd(repo_object, attributes)
      #attributes.each do |k,v|
        #unless 
      #end
    repo_object.name = attributes[:name] unless attributes[:name].nil?
    repo_object.description = attributes[:description] unless attributes[:description].nil?
    repo_object.unit_price = attributes[:unit_price] unless attributes[:unit_price].nil?
    repo_object.status = attributes[:status] unless attributes[:status].nil?
    repo_object.quantity = attributes[:quantity] unless attributes[:quantity].nil?
    repo_object.credit_card_number = attributes[:credit_card_number] unless attributes[:credit_card_number].nil?
    repo_object.credit_card_exp_date = attributes[:credit_card_exp_date] unless attributes[:credit_card_exp_date].nil?
    repo_object.result = attributes[:result] unless attributes[:result].nil?
    repo_object.first_name = attributes[:first_name] unless attributes[:first_name].nil?
    repo_object.last_name = attributes[:last_name] unless attributes[:last_name].nil?
    repo_object.updated_at = Time.now
  end
end
