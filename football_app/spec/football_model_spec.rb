#our tests are focused on the model, since that's where all the logic is happening. 
require 'football_model'

describe FootballModel do 
  before(:each) do
    @model = FootballModel.new
  end

  describe "#get_game_array" do 
    it "when given a file name returns an array of teams" do 
      expect(@model.get_game_array("sample-input.txt")).to include("Lions 3, Snakes 3")
    end
    it "when given an invalid file name it throws an error" do
      expect{@model.get_game_array("no-such-file.txt")}.to raise_error(Errno::ENOENT)
    end
 end

  describe "#generate_hash" do 
    before(:each) do
      @array = ["Lions 3, Snakes 3", "Lions 1, Snakes 3", "Victors 3, Snakes 1"]
    end

    it "returns a hash" do
      expect(@model.generate_hash(@array).class).to eq(Hash)
    end
    it "it doesn't duplicate teams" do 
      expect(@model.generate_hash(@array).length).to eq(3)
    end
    it "the teams have assigned numerical scores" do 
      expect(@model.generate_hash(@array).all?{|key, value| value.class == Fixnum || value.class == Integer}).to be true
    end
    it "doesn't include teams not given" do
      expect(@model.generate_hash(@array).keys).to match_array(["Lions", "Snakes", "Victors"])
    end
  end

  describe "#compare_teams" do 
    it "returns a hash" do
      expect(@model.compare_teams("team", "1", "team", "1").class).to eq(Hash)
    end
    it "if two teams are tied, it returns both teams with a score of 1" do
      expect(@model.compare_teams("team1", "1", "team2", "1")).to eq({"team1" => 1, "team2" => 1})
    end
    it "if team 1 won, it returns team 1 with a score of 3" do
      expect(@model.compare_teams("team1", "8", "team2", "1")).to eq({"team1" => 3})
    end

    it "if team 2 won, it returns team 2 with a score of 3" do
      expect(@model.compare_teams("team1", "0", "team2", "1")).to eq({"team2" => 3})
    end
  end

  describe "#format_results" do
    before(:each) do
      @hash = {
        "team1" => 10,
        "team3" => 5,
        "team6" => 9
      } 

    end

    it "returns an array" do
      expect(@model.format_results(@hash).class).to eq(Array)
    end

    it "is sorted by scores, highest first" do 
      expect(@model.format_results(@hash)).to match_array([["team1", 10], ["team6", 9], ["team3", 5]])
    end

    it "ties are sorted alphabetically " do
      tied_hash = {
        "aaz" => 1,
        "aab" => 1,
        "aac" => 1,
        "c" => 1
      }

       expect(@model.format_results(tied_hash)).to match_array([["aab", 1], ["aac", 1], ["aaz", 1], ["c", 1]])
    end


    it "is ordered numerically and then alphabetically" do 
      alphabet_hash = {
        "b" => 4,
        "a" => 4,
        "za" => 1,
        "zb" => 1,
        "c" => 1,
        "g" => 2
      }
      expect(@model.format_results(alphabet_hash)).to match_array([["a", 4], ["b", 4], ["g", 2], ["c", 1], ["za", 1], ["zb", 1]])

    end
  end

  describe "#insert_ranking" do
    #these tests are a little brittle, but match the scope of the model
    before(:each) do
      @array = [["team 1", 5], ["team2", 3], ["team3", 3], ["team4", 3], ["team4", 1]]
    end

    it "adds a ranking to each item in the array" do
      expect(@model.insert_rankings(@array)[0].length).to eq(3)
    end

    it "the ranking makes logical sense" do
      expect(@model.insert_rankings(@array)[4][2]).to eq(5)
    end


    it "tied results all have the same rank" do
      expect(@model.insert_rankings(@array)[3][2]).to eq(2)
    end

  end
end
