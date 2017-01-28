require 'football_controller'

  #this is really an integration test, and not necessarilly appropriate for all cases
describe FootballController do 
  it "Program runs fully and ouputs expected results to console" do
    view = FootballView.new
    controller = FootballController.new
    allow(view).to receive(:request_input).and_return("sample-input.txt")
    controller.instance_variable_set(:@view,view)
    expect{controller.run}.to output("1. Tarantulas, 6 pts\n2. Lions, 5 pts\n3. FC Awesome, 1 pts\n3. Snakes, 1 pts\n5. Grouches, 0 pts\n").to_stdout
  end
end