module Inspector

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

  def delete(id)
    @all.delete_if do |item|
      item.id == id
    end
  end

  def create(attributes)
    attributes[:id] = @all.max{|item| item.id.to_i}.id + 1
    @all << (@all.first.class).new(attributes)
  end

  def find_by_id(id)
    @all.find do |item|
      item.id == id
    end
  end

  def update(id, attributes)
    @all.find do |item|
      if item.id == id
        item.first_name = attributes[:first_name] unless attributes[:first_name].nil?
        item.last_name = attributes[:last_name] unless attributes[:last_name].nil?
        item.status = attributes[:status] unless attributes[:status].nil?
        item.quantity = attributes[:quantity] unless attributes[:quantity].nil?
        item.unit_price = attributes[:unit_price] unless attributes[:unit_price].nil?
        item.name = attributes[:name] unless attributes[:name].nil?
        item.description = attributes[:description] unless attributes[:description].nil?
        item.unit_price = attributes[:unit_price] unless attributes[:unit_price].nil?
        item.credit_card_number = attributes[:credit_card_number] unless attributes[:credit_card_number].nil?
        item.credit_card_expiration_date = attributes[:credit_card_expiration_date] unless attributes[:credit_card_expiration_date].nil?
        item.result = attributes[:result] unless attributes[:result].nil?
        time_updater(item)
      end
    end
  end

  def time_updater(item)
    if item.class == Merchant
      return
    else
      item.updated_at = Time.now
    end
  end
end
