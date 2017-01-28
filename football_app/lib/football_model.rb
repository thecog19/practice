class FootballModel
  #these methods would customarilly be private, but for the sake of thorough testing they are not. 

  def get_game_array(file_name)
    string = open_file(file_name)
    string.split("\n")
  end

  def open_file(file_name)
    if file_name == "" 
      file_name = "sample-input.txt"
    end
    File.read(file_name)
  end

  def generate_hash(game_array)
    #each element of the game array represents a game, with the teams separated by commas. 

    #this function is kind of long, but we're avoiding doing two loops over the game array by both building and populating the hash in the same loop 
    
    results_hash = {}

    game_array.each do |game|
      team_array = game.split(",")
      team_keys = []
      team_array.each do |team|
        key = team[0..-2].strip
        team_keys << key
        #while this is a nested loop, we're only every iterating over two teams in here
        unless !!results_hash[key]
          results_hash[key] = 0 
        end
      end

      points_outcome = compare_teams(team_keys[0], #team1
                    team_array[0][-1], #score1
                    team_keys[1],  #team 2
                    team_array[1][-1]) #score 2

      points_outcome.each do |team, points|
        results_hash[team] += points
      end

    end

    results_hash
  end

  def compare_teams(team1, score1, team2, score2)
    #returns a key value pair 
    score_hash = {}

    if score1 > score2
      #if team 1 beat team 2, add 3 points to their score
      score_hash[team1] = 3
    elsif score1 < score2
      #add three points if team 2 beat team 1
      score_hash[team2] = 3
    else
      #if neither team won, it was a draw, give both teams a point
      score_hash[team1] = 1
      score_hash[team2] = 1
    end

    score_hash
  end

  def format_results(results_hash)
    #we're using enumerables sort_by to turn the hash into an array
    #(because hashes don't mantain order) and sorting it first by keys, then alphabetically
    #ord is returning the numerical value of the first letter
    #which in ruby are a-z, in increasing order from 97
    sorted_results = results_hash.sort_by {|team, score| [score, -team[0].ord]}

    return sorted_results.reverse
  end

end