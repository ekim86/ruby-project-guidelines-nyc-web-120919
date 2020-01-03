class CommandLineInterface

  def run
    @prompt =  TTY::Prompt.new
    @pastel = Pastel.new
    greet
    start_menu
  end

  def greet
    puts "Welcome to Movie Reservations! 🎬  🍿"
  end

  def start_menu 
    @prompt.select("What Would You Like To Do?", cycle: true, symbols: {marker: '🍿'} ) do |menu|
        menu.choice "Login", -> { login_menu }
        menu.choice "Create An Account", -> { create_account_menu }
        menu.choice "Exit", -> { exit_app }
    end 
  end 

  def login_menu
    email_input = "sasha@email.com"# @prompt.ask("Please enter your email address:")
    password_input = "5555"#@prompt.mask("Please enter your password:")
    user = User.find_by(email: email_input)
      if user && user.password == password_input
        @user = user 
        puts @pastel.bright_cyan("Hello #{user.name.capitalize}")
        main_menu
      else 
        @prompt.error("Email or password is incorrect, please try again.")
        @prompt.select("", cycle: true, symbols: {marker: '🍿'} ) do |menu|
          menu.choice "Try Again", -> { login_menu }
          menu.choice "Create An Account", -> { create_account_menu }
          menu.choice "Exit", -> { exit_app }
        end 
      end 
  end 

  def create_account_menu
    email_input = @prompt.ask("Please enter your email address:")
    user = User.find_by(email: email_input)
      if user
        @prompt.error("This email account is already registered. Please login.") 
        @prompt.select("", cycle: true, symbols: {marker: '🍿'} ) do |menu|
          menu.choice "Login", -> { login_menu }
          menu.choice "Create An Account", -> { create_account_menu }
          menu.choice "Exit", -> { exit_app }
        end 
      else 
        name_input = @prompt.ask("Please enter your name:")
        password_input = @prompt.mask("Please create a password:")
        user = User.create(name: name_input, email: email_input, password: password_input)
        @user = user 
        puts @pastel.bright_cyan("Hello #{user.name.capitalize}")
        main_menu
      end 
  end 

  def main_menu
    @prompt.select("What Would You Like To Do?") do |menu|
      menu.choice "Make a New Ticket Reservation", -> { new_reservation }
      menu.choice "See All Reserved Tickets", -> { all_reservations }
      menu.choice "Exit", -> { exit_app }
    end
  end 

  def new_reservation
    @prompt.select("Which Movie Would You Like To Reserve Tickets For?") do |menu|
      menu.choice "Make a New Ticket Reservation", -> { new_reservation }
      menu.choice "Go Back", -> { main_menu }
      menu.choice "Exit", -> { exit_app }
    end
  end 

  def all_reservations
        user_reservations = @user.reservations.reload
        if @user.reservations[0] == nil 
          @prompt.error("No Reservations Yet. Please Make a Reservation") 
          @prompt.select("") do |menu|
            menu.choice "Make a New Ticket Reservation", -> { new_reservation }
            menu.choice "Go Back", -> { main_menu }
            menu.choice "Exit", -> { exit_app }
          end
        else 
         @prompt.select("") do |menu|
            user_reservations.map do |reservation|
            puts "🙌  You reserved #{reservation.ticket_quantity} ticket(s) for #{reservation.movie.title}"
            end
          menu.choice "Go Back", -> { main_menu }
          menu.choice "Update a Reservation", -> { update_reservations }
          menu.choice "Exit", -> { exit_app }
          end 
      end 
  end 

  def update_reservations
    user_reservations = @user.reservations.reload
    @prompt.select("Which reservation would you like to update? ") do |menu|
      user_reservations.map do |reservation|
        menu.choice "#{reservation.ticket_quantity} ticket(s) for #{reservation.movie.title}", -> { update_reservation(reservation) }
      end 
        menu.choice "Go Back", -> { all_reservations }
        menu.choice "Exit", -> { exit_app }
    end 
  end 

  def update_reservation(reservation)
        reservation_detail = [
          { name: "Movie: #{reservation.movie.title}", disabled: "👎  can't update" },
          { name: "Ticket quantity: #{reservation.ticket_quantity}", value: "Ticket quantity"}
        ]
        user_input = @prompt.select('Choose what you would like to update:', reservation_detail)
        case user_input
        when "Ticket quantity"
          ticket_quantity_list = (1..5).to_a
          new_ticket_quantity = @prompt.select(
            "How many tickets would you like?",
            ticket_quantity_list )
          reservation.update(ticket_quantity: new_ticket_quantity)
        end
        @prompt.select("Your Reservation Has Been Updated: #{reservation.ticket_quantity} ticket(s) for #{reservation.movie.title}") do |menu|
          menu.choice "Go Back", -> { all_reservations }
          menu.choice "Exit", -> { exit_app }
        end 
  end 
       
  
  
  
  
  
  
  
  
  
  #reservation_detail(reservation)
    

    # selected_reservation_id = @prompt.select('Select to see more details', reservations)
    
    #     if selected_reservation_id > 0
    #       selected_reservation = Reservation.find(selected_reservation_id)
    
    #choices = reservations
      #update_choice = @prompt.select("Which reservation would you like to update?", choices)
        
    #     reservations << { name: 'Go Back', value: 0}
    
    #     selected_reservation_id = @prompt.select('Select to see more details', reservations)
    
    #     if selected_reservation_id > 0
    #       selected_reservation = Reservation.find(selected_reservation_id)
    #       reservation_detail(selected_reservation)
    #     end
    #   end
        # reservations << { name: 'Go Back', value: 0}
    
        # selected_reservation_id = @prompt.select('Select to see more details', reservations)
    
        # if selected_reservation_id > 0
        #   selected_reservation = Reservation.find(selected_reservation_id)
        #   reservation_detail(selected_reservation)
        # end

  def exit_app
        puts "See you next time! 👋"
  end

end 

#   def choices(user)
#     choices = [
#       {name: 'See all reserved tickets', value: 1},
#       {name: 'Make a reservation', value: 2},
#       {name: 'Exit', value: 3}
#     ]
#     user_input = @prompt.select('Please select a prompt', choices)
#   end

#   def all_reservations(user)
#     user_reservations = user.reservations.reload
#     reservations = user_reservations.map do |reservation|
#       {
#         name: "🙌  You reserved #{reservation.ticket_quantity} ticket(s) for #{reservation.movie.title}\n-----------------------------------------------",
#         value: reservation.id
#       }
#     end
#     reservations << { name: 'Go Back', value: 0}

#     selected_reservation_id = @prompt.select('Select to see more details', reservations)

#     if selected_reservation_id > 0
#       selected_reservation = Reservation.find(selected_reservation_id)
#       reservation_detail(selected_reservation)
#     end
#   end

#   def reservation_detail(reservation)
#     puts "-----------------------------------------------"
#     puts "🎟  You have #{reservation.ticket_quantity} ticket(s) reserved for #{reservation.movie.title}"
#     puts "-----------------------------------------------"
    
#     choices = [
#       { name: 'Update ticket reservation', value: 1 },
#       { name: 'Delete ticket reservation', value: 2 },
#       { name: 'Go back to all my ticket reservations', value: 3 }
#     ]
#     user_input = @prompt.select("Please choose the following", choices)
#     case user_input
#     when 1
#       update_reservation(reservation)
#     when 2
#       delete_reservation(reservation)
#     when 3
#       all_reservations(reservation.user)
#     end
#   end

#   def update_reservation(reservation)
#     reservation_detail = [
#       { name: "Movie: #{reservation.movie.title}", disabled: "👎  can't update" },
#       { name: "Time: #{reservation.movie.showtimes}", value: "Time" },
#       { name: "Ticket quantity: #{reservation.ticket_quantity}", value: "Ticket quantity"}
#     ]
#     user_input = @prompt.select('Choose what you would like to update:', reservation_detail)
#     case user_input
#     when "Showtime"
#       time_list = ["12:00 PM", "12:15 PM", "12:30 PM", "12:45 PM", "1:00 PM"]
#       new_time = @prompt.select('Choose a new time', time_list, filter: true)
#       reservation.update(time: new_time)
#     when "Ticket quantity"
#       ticket_quantity_list = (1..5).to_a
#       new_ticket_quantity = @prompt.select(
#         'Change how many tickets you want',
#         ticket_quantity_list,
#         filter: true
#       )
#       reservation.update(ticket_quantity: new_ticket_quantity)
#     end

#     reservation_detail(reservation)
#   end

#   def delete_reservation(reservation)
#     options = [
#       { name: 'Y', value: 'y'},
#       { name: 'N', value: 'n'}
#     ]
#     delete_check = @prompt.select("Are you sure you want to delete the reserved ticket(s)?", options)
#     case delete_check
#     when 'y'
#       reservation.delete
#       all_reservations(reservation.user)
#     when 'n'
#       reservation_detail(reservation)
#     end
#   end
  
#   def make_reservation(user)
#     movie_list = Movie.all.map(&:title)
#     chosen_movie = @prompt.select(
#       'Choose your movie',
#       movie_list,
#       filter: true
#       )
#       movie = Movie.find_by(title: chosen_movie)
#       year_list = [2019, 2020]
#       chosen_year = @prompt.select(
#         'Please select a year',
#         year_list,
#         filter: true
#         )
#         month_list = ["January", "February", "March", "April", "May", "June", "July", "August", "Septemer", "October", "November", "December"]
#         chosen_month = @prompt.select(
#           'Please select a month',
#           month_list,
#           filter: true
#           )
#           day_list = (1..31).to_a
#           chosen_day = @prompt.select(
#             'Please select a day',
#             day_list,
#             filter: true
#             )
#             time_list = ["12:00 PM", "12:15 PM", "12:30 PM", "12:45 PM", "1:00 PM"]
#             chosen_time = @prompt.select(
#               'Please select a time',
#               time_list,
#               filter: true
#               )
#               ticket_quantity_list = (1..5).to_a
#               chosen_ticket_quantity = @prompt.select(
#                 'How many tickets would you like?',
#                 ticket_quantity_list,
#                 filter: true
#                 )
#                 Reservation.create(
#                   user_id: user.id,
#                   movie_id: movie.id,
#                   # month: chosen_month,
#                   # day: chosen_day,
#                   # year: chosen_year,
#                   # time: chosen_time,
#                   ticket_quantity: chosen_ticket_quantity
#                   )
#                 end

#   def run
#     greet
#     @prompt =  TTY::Prompt.new
#     @pastel = Pastel.new
#     user = start
#     return exit_app if !user.is_a?(User)

#     user_input = choices(user)
#     while user_input != 3
#       case user_input
#       when 1
#         all_reservations(user)
#       when 2
#         make_reservation(user)
#       end
#       user_input = choices(user)
#     end
#     exit_app
#   end

# end