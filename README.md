Module One Final Project - Travel Ta Life
=========================================

---

## Project background

Building a **Command Line CRUD App** that uses a database to persist information. The goal of which is to demonstrate all the following skills:

- Ruby
- Object Orientation
- Relationships (via ActiveRecord)
- Problem Solving (via creating a Command Line Interface (CLI))

The project:

1. Contains at three models with three tables, including a join table.
2. Accesses a Sqlite3 database using ActiveRecord.
3. Has a CLI that allows users to interact with the database as defined by the user story.
4. Uses good OO design patterns.

---

## Travel Ta Life CLI application

Use my little travel log app to keep track of your trips and create new ones. You can also
specify activities you've done on a trip and write a post about it. Lastly, you can browse the world
with an interactive world map in the terminal, as well as get more infos on a country you're curious about.

---

## Getting started

Fork and clone the repository: https://github.com/manonja/guided-module-one-project-assessment-london-web-career-031119

Run `bundle install` in your terminal to install the dependencies needed

Run Travel Ta Life in your command line by running:
`rake run`

The main menu should appear in your terminal!

---

## Uses

1. You will be asked for your name, so first, enter your name!

2. You can now choose between different options:
    - Trips
    - Activities
    - Browse the world
    - Exit

3. If you choose Trips, you can:
    - View my trips
    - Create a new trip
    - Delete a trip
    - Main menu
    - Exit

4. If you choose Activities, you can:
    - View your activities
    - Create a new activity
    - Edit a post
    - View the most popular activity
    - Main menu
    - Exit

5. If you choose Browse the world, you can:
    - Get country facts
    - Get real
    - Main main
    - Exit

  ---


## MVP and stretch goals

### MVP

- Include a basic menu in the CLI with which the user can interact
- Show traveler's trip
- Let the traveler create a new trip and save it to the database
- Show traveler's activities and let him create new ones
- Let the traveler delete a trip
- Include different menus
- Use an API

### Stretch goals

- Include Skyscanner API so a user can know how to get to his next trip
- Get animated art in the CLI
- Enable uppercase, lowercase and mixed-case user input
- Include colour in the command line interface using ASCII art gems
- Include MAPSCII so we can display a world map in the terminal

## gems used
- gem "sinatra-activerecord"
- gem "sqlite3"
- gem "pry"
- gem json
- gem "require_all"
- gem 'rest-client'
- gem "faker"
- gem "rake"
- gem 'artii'
- gem 'rainbow'
- gem "lolcat"

## Author

Manon Jacquin - https://github.com/manonja
