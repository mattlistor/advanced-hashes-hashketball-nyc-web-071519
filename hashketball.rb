def game_hash
  hash = {
    :home => {
      :team_name => "Brooklyn Nets",
      :colors => ["Black", "White"],
      :players => {
        "Alan Anderson" => {
          :number => 0,
          :shoe => 16,
          :points => 22,
          :rebounds => 12,
          :assists => 12,
          :steals => 3,
          :blocks => 1,
          :slam_dunks => 1
        },
        "Reggie Evans" => {
          :number => 30,
          :shoe => 14,
          :points => 12,
          :rebounds => 12,
          :assists => 12,
          :steals => 12,
          :blocks => 12,
          :slam_dunks => 7
        },
        "Brook Lopez" => {
          :number => 11,
          :shoe => 17,
          :points => 17,
          :rebounds => 19,
          :assists => 10,
          :steals => 3,
          :blocks => 1,
          :slam_dunks => 15
        },
        "Mason Plumlee" => {
          :number => 1,
          :shoe => 19,
          :points => 26,
          :rebounds => 11,
          :assists => 6,
          :steals => 3,
          :blocks => 8,
          :slam_dunks => 5
        },
        "Jason Terry" => {
          :number => 31,
          :shoe => 15,
          :points => 19,
          :rebounds => 2,
          :assists => 2,
          :steals => 4,
          :blocks => 11,
          :slam_dunks => 1
        }
      }
    },
    :away => {
      :team_name => "Charlotte Hornets",
      :colors => ["Turquoise", "Purple"],
      :players => {
        "Jeff Adrien" => {
          :number => 4,
          :shoe => 18,
          :points => 10,
          :rebounds => 1,
          :assists => 1,
          :steals => 2,
          :blocks => 7,
          :slam_dunks => 2
        },
        "Bismack Biyombo" => {
          :number => 0,
          :shoe => 16,
          :points => 12,
          :rebounds => 4,
          :assists => 7,
          :steals => 22,
          :blocks => 15,
          :slam_dunks => 10
        },
        "DeSagna Diop" => {
          :number => 2,
          :shoe => 14,
          :points => 24,
          :rebounds => 12,
          :assists => 12,
          :steals => 4,
          :blocks => 5,
          :slam_dunks => 5
        },
        "Ben Gordon" => {
          :number => 8,
          :shoe => 15,
          :points => 33,
          :rebounds => 3,
          :assists => 2,
          :steals => 1,
          :blocks => 1,
          :slam_dunks => 0
        },
        "Kemba Walker" => {
          :number => 33,
          :shoe => 15,
          :points => 6,
          :rebounds => 12,
          :assists => 12,
          :steals => 7,
          :blocks => 5,
          :slam_dunks => 12
        }
      }
    }
  }
end

def num_points_scored(player_name)
  game_hash.each do |location, team_data|
    team_data.each do |attribute, data|
       if data.include?(player_name) 
       return game_hash[location][attribute][player_name][:points]
      end 
    end
  end
end

def shoe_size(player_name)
  game_hash.each do |location, team_data|
    team_data.each do |attribute, data|
       if data.include?(player_name) 
       return game_hash[location][attribute][player_name][:shoe]
      end 
    end
  end
end

def team_names
  team_array = []
  game_hash.each do |location, team_data|
    team_array.push(team_data[:team_name])
  end
  return team_array
end

def team_colors(team_name)
  game_hash.each do |location, team_data|
    team_data.each do |attribute, data|
      if team_data[:team_name] == team_name && attribute == :colors 
        return data
      end
    end
  end
end

def player_numbers(team_name)
  number_array = []
  game_hash.each do |location, team_data|
    team_data.each do |attribute, data|
      if team_data[:team_name] == team_name && attribute == :players
        data.each do |player, stats|
          number_array.push((game_hash[location][:players][player][:number]).to_i)
        end
      end
    end
  end
  return number_array
end

def player_stats(name)
  game_hash.each do |location, team_data| 
    team_data.each do |attribute, data| 
      if data.include?(name) 
       return game_hash[location][attribute][name]
      end
    end
  end
end

def big_shoe_rebounds
  biggest_shoe = nil
  biggest_shoe_most_rebounds = nil
  game_hash.each do |location, team_data|
    team_data.each do |attribute, data|
      if attribute == :players
        data.each do |player_name, stats|
          stats.each do |stat_name, shoe_size|
            if stat_name == :shoe
              if biggest_shoe == nil || shoe_size > biggest_shoe
                biggest_shoe = shoe_size
                biggest_shoe_most_rebounds = game_hash[location][:players][player_name][:rebounds]
              end
            end
          end
        end
      end
    end
  end
  biggest_shoe_most_rebounds
end

def most_points_scored
  most_points_num = 0
  most_points_player = "player"
  game_hash.each do |location, team_data|
    team_data.each do |attribute, data|
      if attribute == :players
        data.each do |player_name, stats|
          stats.each do |stat_name, points|
            if points > most_points_num
              most_points_num = points
              most_points_player = player_name
            end
          end
        end
      end
    end
  end
  most_points_player
end

 def winning_team
  home_team_point_total = 0
  away_team_point_total = 0
  game_hash.each do |location, team_data|
    if location == :home
      team_data.each do |attribute, data|
        if attribute == :players
          data.each do |player_name, stats|
            home_team_point_total += num_points_scored(player_name)
          end
        end
      end
    elsif location == :away
      team_data.each do |attribute, data|
        if attribute == :players
          data.each do |player_name, stats|
            away_team_point_total += num_points_scored(player_name)
          end
        end
      end
    end
  end
  
  if home_team_point_total > away_team_point_total
    return game_hash[:home][:team_name]
  else
    return game_hash[:away][:team_name]
  end
  
end

 def player_with_longest_name
  longest_name_length = 0
  longest_name_string = "player"
  game_hash.each do |location, team_data|
    team_data.each do |attribute, data|
      if attribute == :players
        data.each do |player_name, stats|
          if player_name.length > longest_name_length
            longest_name_length = player_name.length
            longest_name_string = player_name
          end
        end
      end
    end
  end
  longest_name_string
end

def player_with_best_steals
  best_steals_num = 0
  best_steals_name = "player"
  game_hash.each do |location, team_data|
    team_data.each do |attribute, data|
      if attribute == :players
        data.each do |player_name, stats|
          if stats[:steals] > best_steals_num
            best_steals_num = stats[:steals]
            best_steals_name = player_name
          end
        end
      end
    end
  end
  best_steals_name
end 

def long_name_steals_a_ton?
  if player_with_best_steals == player_with_longest_name
    return true
  end
end 
