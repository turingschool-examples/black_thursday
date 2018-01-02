class MerchantRepository

  def initialize(file_path)
    @merchants = []
    parse(file_path)
  end

  def all
  end

  def find_by_id(id)
  end

  def find_by_name(name)
  end

  def find_all_by_name(name)
  end

end
