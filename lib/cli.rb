require 'tty'
require 'tty-prompt'

class CLI

  def initialize
    system ("clear")
    @prompt = TTY::Prompt.new
    system("Figlet Travel Ta Life")
  end

  def get_traveller_name
    name = @prompt.ask("Hello, bonjour, Доброе утро, what's your name?")
    @traveller = Traveller.find_or_create_by(name: name)
  end

  def welcome
    system("Figlet Hey #{@traveller.name}, Welcome!")
  end

  def main_menu
    choices = {
        'Trips': :trips,
        'Activities': :activities,
        'Browse the world': :browse,
        'Exit Travel Ta Life': :quit
      }
    answer = @prompt.select("What are you up to?", choices)

    if answer == :trips
      trip_menu

    elsif answer == :activities
      activity_menu

    elsif answer == :browse
      system("mapscii")

    elsif answer == :quit
      quit
    else
      main_menu
    end

  end

  def trip_menu
    choices = {
        'View my trips': :view,
        'Add new trip': :add,
        'Delete trip': :delete,
        'Main menu': :main,
        'Exit Travel Ta Life': :quit

      }
    answer = @prompt.select("Choose your destiny", choices)

    if answer == :view
      view_trips
      trip_menu
    elsif answer == :add
      add_trip
      trip_menu
    elsif answer == :delete
      delete_trip
      trip_menu
    elsif answer == :main
      main_menu
    elsif answer == :quit
      quit
    else
      trip_menu
    end
  end

  def activity_menu
    choices = {
        'View my activities': :view,
        'Create new activity': :create,
        'Edit post on activity': :edit,
        'View most popular activity': :popular,
        'Main menu': :main,
        'Exit Travel Ta Life': :quit

      }
    answer = @prompt.select("Choose your destiny", choices)

    if answer == :view
      view_activities
      activity_menu
    elsif answer == :create
      add_activity
      activity_menu
    elsif answer == :edit
      edit_post_on_activity
      activity_menu
    elsif answer == :popular
      most_popular_activity
      activity_menu
    elsif answer == :main
      main_menu
    elsif answer == :quit
      quit
    else
      activity_menu
    end
  end


  def view_trips
    puts " "
    puts " "
    puts "*********************************************"
    puts "     ***********************************"
    puts "              *****************"
    puts "                  *********"
    puts "                    *****"
    puts "                     ***"
    puts "                      * "


    # update traveler
    @traveller = Traveller.find_by(name: @traveller.name)

    if @traveller.trips.length > 0
      @traveller.trips.uniq.each do |trip|
      puts " "
      puts " "
      puts "Here the trips you currently have in your log: "
      puts " "
      puts " "
      puts "#{trip.city} | #{trip.country}"
      puts " "
      puts " "
      end
      puts "Cool! Let's do something else!"
      puts " "
      puts " "
    else
      puts "_____________________________________________________________"
      puts "...No saved trip yet... But guess what, you can add one now!"
      puts "_____________________________________________________________"

    end

  end

  def view_activities
    puts "_____________________________________________________________"
    puts "Here the activities you've done in your previous trips: "
    puts "_____________________________________________________________"
    @traveller = Traveller.find_by(name: @traveller.name)

    if @traveller.activities.length > 0
      @traveller.activities.each do |activity|
        puts "*********************************************"
        puts activity.activity_name if (activity.activity_name != nil)
        puts "*********************************************"
      end
    else
      puts "_____________________________________________________________"
      puts "No activity in your log yet. But let's add one!"
      puts "_____________________________________________________________"

    end
  end

  def add_trip
    puts "Create a new trip below: "
    new_trip = @prompt.collect do
      key(:city).ask('City?')
      key(:country).ask('Country?')
    end

    trip = Trip.find_or_create_by(new_trip)
    @traveller.trips << trip
    trip
    puts "Cool, you just created a new trip."
  end

  def add_activity

    puts "Enter a new activity below"
    new_activity = {}

    new_activity[:activity_name] = @prompt.ask('Activity?')
    new_activity[:comment] = @prompt.ask('Comment?')
    new_activity[:traveller] = @traveller

    if @traveller.trips.length > 0
      trip_name = @prompt.select('Where was that?', @traveller.get_cities)
      new_activity[:trip] = Trip.find_by(city: trip_name)
    else
      new_activity[:trip] = add_trip
    end

    activity = @traveller.add_new_activity(new_activity)
  end

  def edit_post_on_activity
    @traveller = Traveller.find_by(name: @traveller.name)

    choices = @traveller.get_activities

    select_activity = @prompt.select("Which post would you like to change?", choices)

    activity = Activity.find_by(activity_name: select_activity)

    # put in the console the current trip, activity, and comment
    puts "Activity: #{activity.activity_name} | Current post: #{activity.comment}"
    new_comment = @prompt.ask("Type your new post: ")
    # set the new comment to the user input
    activity.comment = new_comment
    # save it to the database
    activity.save

  end

  def most_popular_activity
    puts "#{Activity.most_popular_activity}"
  end

  def delete_trip
    @traveller = Traveller.find_by(name: @traveller.name)
    choices = @traveller.get_cities
    to_delete = @prompt.select("Choose your destiny and remove me...", choices)
    # destroy the relationship between traveller and destination
    @city = Trip.find_by(city: to_delete)
    @city.destroy
  end

  def quit
   system("Figlet byebye!")
  end

  def start
    get_traveller_name
    welcome
    main_menu
  end
end
