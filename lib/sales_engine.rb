class SalesEngine
  attr_reader :merchants, :items
  def self.from_csv(csv_data)
    @merchants = csv_data[:merchants]
    @items = csv_data[:items]
  end
  #
  # def items(items_data)
  #
  # end
  #
  # def merchants(merchants_data)
  #
  # end
  def self.parse_csv(path)
    
  end


end

#
# needs to intake the files and then make them usable by both merchant repo and item repo. intake files from_csv method.
#
# items method will return an instance of item repository. item repository will have all of the items in it.
#
# merchant method will return an instance of merchant repository. merchant repository gets created with all of the merchant objects



# Leigh's group project
# class StatTracker
#   attr_reader :games_data,
#               :team_data,
#               :game_teams_data,
#               :game_manager,
#               :game_team_manager,
#               :team_manager
#
#   def initialize(locations)
#     load_manager(locations)
#   end
#
#   def self.from_csv(locations)
#     StatTracker.new(locations)
#   end
#
#   def load_manager(locations)
#    @team_manager = TeamManager.new(load_csv(locations[:teams]), self)
#    @game_manager = GameManager.new(load_csv(locations[:games]), self)
#    @game_team_manager = GameTeamsManager.new(load_csv(locations[:game_teams]), self)
#   end
#
#   def load_csv(path)
#     CSV.parse(File.read(path), headers: true, header_converters: :symbol)
#   end
