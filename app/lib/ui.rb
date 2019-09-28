class Ui

  PROMPT = TTY::Prompt.new
  PROGRESS = TTY::ProgressBar.new("Keep going... [:bar]", output: $stdout, total: 10)
  #
  #   Print :: $stdout stuff
  #

  def header
    puts`clear`
    PROMPT.say "
 ██████╗  ██╗   ██╗ ██╗ ███████╗
██╔═══██╗ ██║   ██║ ██║ ╚══███╔╝    head-to-head
██║   ██║ ██║   ██║ ██║   ███╔╝     and claim
██║▄▄ ██║ ██║   ██║ ██║  ███╔╝      victory over
╚██████╔╝ ╚██████╔╝ ██║ ███████╗    your friends
 ╚═▀▀══╝   ╚═════╝  ╚═╝ ╚══════╝
    \n"
  end

  def welcome
    name = PROMPT.ask 'What is your name ?'
    @user = User.find_or_create_by(name: name)
  end

  def goodbye
    PROMPT.error "Bye! #{@user.name}"
  end

  def show_progress
    puts "\n"
    PROGRESS.advance
    PROMPT.warn " level #{@level}/3"
  end

  def show_stats
    PROMPT.say "Ace! #{@user.right_answers_last10}/10 in #{@user.time.round(0)} seconds"
  end

  def show_leaderboard
    User.results(@user)
  end

  #
  #   CRUD :: add_leaderboard=create delete_user=delete clear_data=destroy
  #

  def add_leaderboard(result)
    Leaderboard.create(question_id: @random.id, user_id: @user.id, result: result)
  end

  def delete_user
    User.delete(@user.id)
    PROMPT.error 'Profile deleted!'
  end

  def clear_data
    Leaderboard.where(user:@user).destroy_all
    PROMPT.ok 'Results cleared!'
  end

  def edit_name
    new_name = PROMPT.ask "Change #{@user.name} to:"
    User.find_by(name: @user.name).update(name: new_name)
    @user = User.find_by(name: new_name)
    PROMPT.ok 'Name changed!'
  end

  #
  #   Game logic :: new_game=init difficulty=setter new_game?=menu handle_question=loop
  #

  def difficulty
    if @session_ratio > 85
      @level = 3
      @random = Question.where(difficulty: 'hard')[rand(40)]
    elsif @session_ratio > 60
      @level = 2
      @random = Question.where(difficulty: 'medium')[rand(40)]
    else
      @level = 1
      @random = Question.where(difficulty: 'easy')[rand(40)]
    end
  end

  def answer
    if difficulty && @questions.include?(@random) == false
      show_progress
      choices = [@random.answer, @random.wrong_1, @random.wrong_2, @random.wrong_3].shuffle
      PROMPT.select(@random.question, choices)
    elsif PROGRESS.current < 9 && @questions.count < 40
      answer
    else
      @questions = []
      answer
    end
  end

  def question
    @session_ratio = @user.result || 0
    @questions = []
    until PROGRESS.complete?
      if answer == @random.answer
        PROMPT.ok 'Right!'
        add_leaderboard(true)
      else
        PROMPT.error "Close, try #{@random.answer}"
        add_leaderboard(false)
      end
      @questions << @random
    end
    show_stats
  end

  def menu
    header
    welcome
    choices = ['new game', 'leaderboard', 'edit profile', 'clear results', 'delete profile', 'exit']
    exit = false
    until exit
      case PROMPT.select("\nWhat do you want to do now #{@user.name}?", choices)
      when 'new game'
        PROGRESS.reset
        question
      when 'edit profile'
        edit_name
      when 'leaderboard'
        show_leaderboard
      when 'clear results'
        clear_data
      when 'delete profile'
        delete_user
        header
        welcome
      when 'exit'
        exit = true
      end
    end
    goodbye
  end

end
