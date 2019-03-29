require 'tty'
require 'json'
require 'tty-prompt'
require 'rest-client'
require 'rainbow'
require 'pry'

class CLI


  def initialize
    system ("clear")
    @prompt = TTY::Prompt.new(active_color: :cyan)
    system ("artii 'Travel Ta Life' --font slant | lolcat")

  end

  def get_traveller_name
    puts "*" * 60

    name = @prompt.ask("Hello, bonjour, Доброе утро, what's your name?") do |q|
      q.required true
      q.validate /\A\w+\Z/
      q.modify :capitalize
    end
    @traveller = Traveller.find_or_create_by(name: name)
  end

  def welcome
    system("Figlet Hey #{@traveller.name}, Welcome! | lolcat")
    puts " "
  end

  def main_menu

    choices = {
        'Trips': :trips,
        'Activities': :activities,
        'Browse the world': :browse,
        'Exit Travel Ta Life': :quit
      }

    puts "====================================================================================================================="
    answer = @prompt.select("                                What are you up to?               ", choices)

    if answer == :trips
      trip_menu
    elsif answer == :activities
      activity_menu
    elsif answer == :browse
      browse_world_menu
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
      puts "==================================================================================="
    elsif answer == :add
      add_trip
      trip_menu
      puts "==================================================================================="
    elsif answer == :delete
      delete_trip
      trip_menu
      puts "==================================================================================="
    elsif answer == :main
      main_menu
      puts "==================================================================================="
    elsif answer == :quit
      quit
      puts "==================================================================================="
    else
      trip_menu
      puts "==================================================================================="
    end
  end

  def activity_menu

    choices = {
        'View my activities': :view,
        'Create new activity': :create,
        'Edit post on activity': :edit,
        'View most popular activity in the database!': :popular,
        'Main menu': :main,
        'Exit Travel Ta Life': :quit

      }

    answer = @prompt.select("Choose your destiny", choices)

    if answer == :view
      puts "==================================================================================="
      view_activities
      activity_menu
    elsif answer == :create
      puts "==================================================================================="
      add_activity
      activity_menu
    elsif answer == :edit
      puts "==================================================================================="
      edit_post_on_activity
      activity_menu
    elsif answer == :popular
      puts "==================================================================================="
      most_popular_activity
      activity_menu
    elsif answer == :main
      puts "==================================================================================="
      main_menu
    elsif answer == :quit
      puts "==================================================================================="
      quit
    else
      puts "==================================================================================="
      activity_menu
    end
  end

  def browse_world_menu
    choices = {
        'Country facts': :view,
        'Get real': :browse,
        'Main menu': :main,
        'Exit Travel Ta Life': :quit
      }
    answer = @prompt.select("COOL STUFF AHEAD", choices)

    if answer == :view
      country_facts
      browse_world_menu
      puts "==================================================================================="
    elsif answer == :browse
      system("mapscii")
      browse_world_menu
      puts "==================================================================================="
    elsif answer == :main
      main_menu
      puts "==================================================================================="
    elsif answer == :quit
      quit
      puts "==================================================================================="
    else
      browse_world_menu
      puts "==================================================================================="
    end
  end


  def view_trips

    # update traveler
    # @traveller = Traveller.find_by(name: @traveller.name)

    if @traveller.trips.length > 0
      @traveller.trips.uniq.each do |trip|
      puts "==================================================================================================="
      puts Rainbow("                               #{trip.city} | #{trip.country}").yellow
      puts "==================================================================================================="

    end

      puts Rainbow("                     Cool, Let's do something else!").blue.bright

    else
      puts "==================================================================================================="
      puts Rainbow("                      ...No saved trip yet... But guess what, you can add one now!").magenta
      puts "==================================================================================================="

    end

  end

  def view_activities
    puts Rainbow("                        Here the activities you've done in your previous trips: ").magenta

    @traveller = Traveller.find_by(name: @traveller.name)

      @traveller.activities.each do |activity|
        # activity.activity_name != nil
        if activity.activity_name != nil

        puts "=========================================================================================================================================="
        puts "#{                   activity.activity_name}"
        puts "=========================================================================================================================================="

        # binding.pry
        # 1
      else
        puts "=========================================================================================================================================="
        puts "                                No activity in your log yet. But let's add one!"
        puts "=========================================================================================================================================="
      end

    end
  end

  def add_trip
    puts "Create a new trip below: "
    new_trip = @prompt.collect do
      key(:city).ask('City?')
      key(:country).ask('Country?')

    end

    @trip = Trip.find_or_create_by(new_trip)
    @traveller.trips << @trip
    @trip
    puts "============================================================================================================================================="
    puts Rainbow("                                Cool, you just created a new trip.").yellow
  end

  def add_activity

    puts "Enter a new activity below"
    new_activity = {}

    new_activity[:activity_name] = @prompt.ask('Activity?')
    new_activity[:comment] = @prompt.ask('Comment?')
    new_activity[:traveller] = @traveller

    if @traveller.trips.length > 0
      puts "==========================================================================================================================================="
      trip_name = @prompt.select('Where was that?', @traveller.get_cities)
      new_activity[:trip] = Trip.find_by(city: trip_name)
    else
      puts "==========================================================================================================================================="
      puts "                                                     Where was that?"
      new_activity[:trip] = add_trip

    end

    activity = @traveller.add_new_activity(new_activity)
  end

  def edit_post_on_activity
    @traveller = Traveller.find_by(name: @traveller.name)
    choices = @traveller.get_activities

    if choices != []
    select_activity = @prompt.select("Which post would you like to change?", choices)
    activity = Activity.find_by(activity_name: select_activity)

    puts "============================================================================================================================================"
    puts Rainbow("                                       Activity: #{activity.activity_name} | Current post: #{activity.comment}").magenta
    puts "============================================================================================================================================"

    new_comment = @prompt.ask("Type your new post: ")
    # set the new comment to the user input
    activity.comment = new_comment
    # save it to the database
    activity.save

    else
      puts Rainbow("                               Hey, you don't have any activity saved so far!").magenta
    end
  end

  def most_popular_activity
    puts "============================================================================================================================================"
    puts "                                   People ❤ #{Activity.most_popular_activity}"
    puts "============================================================================================================================================"

  end

  def delete_trip
    # binding.pry
    # 1
    @traveller = Traveller.find_by(name: @traveller.name)
    choices = @traveller.get_cities
    if choices != []
      to_delete = @prompt.select("Choose your destiny and remove me...", choices)
      # destroy the relationship between traveller and destination
      @city = Trip.find_by(city: to_delete)
      @city.destroy
    else
      puts "=========================================================================================================================================="
      puts Rainbow("                        You don't have anything to delete....").aliceblue
    end
  end

  def get_country_data(name)
    url = "https://restcountries.eu/rest/v2/name/#{name}"
    response = RestClient.get(url)
    # get an array of hashes
     data = JSON.parse(response)
     data_hash = data[0]
     # get the country name
     country = data_hash["name"]
     capital = data_hash["capital"]
     population = data_hash["population"]
     languages = []
     data_hash["languages"][0].each {|key, value| languages << value}
     # binding.pry
     puts "============================================================================================================================================"
     puts Rainbow("                                              Country: #{country}  \n
                                              Capital: #{capital}  \n
                                              Population: #{population} \n
                                              Languages spoken in this country: #{languages.join(", ")}.").pink
                                              puts "==================================================================================================="

  end

  def country_facts
    answer = @prompt.ask("Which country are you curious about?")
    get_country_data(answer)
  end

  def quit
   system("sl")
  end

  def start
    get_traveller_name
    welcome
    main_menu
  end
end
