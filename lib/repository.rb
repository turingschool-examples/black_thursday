class Repository
  attr_reader
  def initialize
    @instances = []
  end

  def all
    @instances
  end


  class MerchantRepository
    attr_reader
    def initialize :all
      @instances = []
      @merchants = []
    end

    def all
      @instances
    end

    def find_by_id(id)
      @instances.find{|instance| instance.id == id }
    end
  end



end
