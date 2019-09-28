class User < ActiveRecord::Base
  has_many :leaderboards
  has_many :questions, through: :leaderboards

  def questions
    Leaderboard.where(user_id: self.id)
  end

  def right_answers
    Leaderboard.where(user_id: self.id, result: true)
  end

  def right_answers_last10
    Leaderboard.where(user_id: self.id).order(updated_at: :desc).limit(10).select{|q|q.result == true}.count
  end

  def result
    right_answers.count.to_f/questions.count.to_f * 100
  end

  def time
    all_results = Leaderboard.where(user_id: self.id).order(updated_at: :desc).limit(10)
    all_results.first.updated_at - all_results.last.updated_at
  end

  def self.results(user)
    hash = {}
    self.all.each_with_index {|u| hash[u.name] = "#{u.result.round(0)}%         |     #{u.time.round(0)}" }
    results = hash.sort_by {|i,v| v.scan(/\d+/).first.to_i}.reverse
    puts "---------------------------------------- "
    puts "   User   |    Ratio(%)    |   Speed(s)  "
    puts "---------------------------------------- "
    results.each do |user, result|
    puts " #{user.ljust(10)}|   #{result}    "
    end
    index = results.index{|i| i.include?(user.name)}
    if index == 0
      puts "Great.. you are the Champion"
    elsif index <= 3
      puts "Lets celebrate, you are in top 3"
      puts "You came in position #{index + 1}"
    elsif index <= 10
      puts "You are in top 10"
      puts "You came in position #{index + 1}"
    else
    puts "Oh #{user.name}, #{user.name}!!!, Make sure nobbody is looking as I am about to reaveal your score"
    sleep 2
    puts "You came in position #{index + 1}"
    end
  #  return results
  end


end
