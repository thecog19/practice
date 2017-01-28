require_relative 'football_model' 
require_relative 'football_view' 

class FootballController

  def initialize
    @model = FootballModel.new
    @view = FootballView.new
  end

  def run
    input = @view.request_input
    game_array = @model.get_game_array(input)
    results_hash = @model.generate_hash(game_array)
    fomatted_results = @model.format_results(results_hash)
    @view.output_results(fomatted_results)
  end


end