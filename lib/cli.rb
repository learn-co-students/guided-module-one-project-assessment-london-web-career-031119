class CLI

  def initialize
    @prompt = TTY::Prompt.new
  end

  def get_traveller_infos
    name = @prompt.ask("Hello, bonjour, Доброе утро, what's your name?")
    @user = Traveller.find_or_create_by(name: name)
  end

  def welcome
    puts "#{@user.name}, welcome to Travel Ta Life!"
  end


  def start
    get_traveller_infos
    welcome
  end

end
