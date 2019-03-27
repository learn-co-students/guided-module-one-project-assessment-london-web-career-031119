require 'tty'
require 'tty-prompt'

class CLI

  def initialize
    @prompt = TTY::Prompt.new
  end

  def get_traveller_name
    name = @prompt.ask("Hello, bonjour, Доброе утро, what's your name?")
    @traveller = Traveller.find_or_create_by(name: name)
  end

  def welcome
    puts "Hey #{@traveller.name}, welcome to Travel Ta Life!"
  end

  def menu
    choices = {
        'Check your saved trips': :view ,
        'Add trip': :add_trip,
        'Add activity on a trip': :add_activity,
        'Edit post on activity': :edit,
        'Browse the world': :browse,
        'Delete trip': :delete,
        'Exit Travel Ta Life': :quit
      }
    answer = @prompt.select("What are you up to?", choices)

    if answer == :view
      view_trips
      menu

    elsif answer == :add_trip
      puts "Cool, let's add a new trip!"
      puts "You've just added a new trip."
      menu

    elsif answer == :add_activity
      view_activities
      add_activity
      puts "Cool, you just added a new activity to your log"
      menu

    elsif answer == :edit
      edit_comment_on_activity
      puts "New post saved!"
      menu

    elsif answer == :browse
      puts "Cool! Run mapscii in your terminal. Arrows to move up, down, left or right. 
      Press a or z to zoom in and out.
      Press q to exit. "


    elsif answer == :delete
      delete_destination
      menu

    elsif answer == :quit
      puts "bye bye"
    else
      menu
    end

  end


  def view_trips
    puts "Here the trips you currently have in your log: "
    # update traveler
    @traveller = Traveller.find_by(name: @traveller.name)

    if @traveller.trips.length > 0
      @traveller.trips.uniq.each do |trip|
      puts trip.city
      end
      puts "Cool! Let's do something else!"
    else
      puts "...No saved trip yet... But guess what, you can add one now!"
    end

  end

  def view_activities
    puts "Here the activities you've done in your previous trips: "
    @traveller = Traveller.find_by(name: @traveller.name)

    if @traveller.activities.length > 0
      @traveller.activities.each do |activity|
        puts activity.activity_name if activity.activity_name != nil

      end
    else
      puts "No activity in your log yet!"
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

  def edit_comment_on_activity
    @traveller = Traveller.find_by(name: @traveller.name)

    choices = @traveller.get_activities

    select_activity = @prompt.select("Which post would you like to change?", choices)

    activity = Activity.find_by(activity_name: select_activity)

    # put in the console the current trip, activity, and comment:
    # TODO add trip
    puts "Activity: #{activity.activity_name} | Current post: #{activity.comment}"
    new_comment = @prompt.ask("Type your new post: ")
    # set the new comment to the user input
    activity.comment = new_comment
    # save it to the database
    activity.save

  end

  def delete_destination
    @traveller = Traveller.find_by(name: @traveller.name)
    choices = @traveller.get_cities
    to_delete = @prompt.select("Choose your destiny and remove me...", choices)
    # destroy the relationship between traveller and destination
    @city = Trip.find_by(city: to_delete)
    @city.destroy
  end

  def start
    get_traveller_name
    welcome
    menu

  end
end
