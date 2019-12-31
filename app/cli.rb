class CommandLineInterface

  def greet
    puts "Welcome to Movie Reservations! 🎬  🍿"
  end

  def start
    choices = [
      {name: 'Login', value: 1},
      {name: 'Create a username', value: 2},
      {name: 'Exit', value: 3}
    ]
  
    user_input = @prompt.select('What would you like to do?', choices, symbols: {marker: '🍿  '}) do |menu|
      menu.choice 'Login', -> do
        user_email_input = @prompt.ask("Email:")
        user = User.find_by(email: user_email_input)
        user_password_input = @prompt.mask("Password:")
        if user.password != user_password_input
          puts "Wrong password, please try again."
          attempt = 0
          while attempt < 2
            user_password_input = @prompt.mask("Password:")
            if user.password == user_password_input
              puts @pastel.bold.bright_magenta("Hello #{user.name.capitalize}")
              # can delete hello
              # can hit another method
              # binding.pry
              break
            end
            puts "Wrong password, please try again."
            attempt += 1
            # figure out how to make user nil on the 3rd attempt
          end
        end
        user
        # puts pastel.bright_cyan("Hello #{user.name.capitalize}")
        # still shows up when you exit with wrong password
      end
      menu.choice 'Create an account', -> do
        user_name_input = @prompt.ask("Please enter your name:")
        user_email_input = @prompt.ask("Please enter your email address:")
        user_password_input = @prompt.mask("Please create a password:")
        User.create(
          name: user_name_input,
          email: user_email_input,
          password: user_password_input
        )
      end
      menu.choice 'Exit', -> do
        exit_app
      end
    end
  end


  def choices(user)
    
    choices = [
      {name: 'See all reserved tickets', value: 1},
      {name: 'Make a reservation', value: 2},
      {name: 'Exit', value: 3}
    ]

    user_input = @prompt.select('Please select a prompt', choices, symbols: {marker: '🍿  '})
  end

  def all_reservations(user)
    user_reservations = user.reservations.reload
    reservations = user_reservations.map do |reservation|
      {
        name: @pastel.bright_blue("🙌  You reserved #{reservation.ticket_quantity} ticket(s) for #{reservation.movie.title}\n-----------------------------------------------"),
        value: reservation.id
      }
    end
    reservations << { name: 'Go Back', value: 0}

    selected_reservation_id = @prompt.select('Select to see more details', reservations, symbols: {marker: '🍿  '})

    if selected_reservation_id > 0
      selected_reservation = Reservation.find(selected_reservation_id)
      reservation_detail(selected_reservation)
    end
  end

  def reservation_detail(reservation)
    puts "-----------------------------------------------"
    puts "🎟  You have #{reservation.ticket_quantity} ticket(s) reserved for #{reservation.movie.title}"
    puts "-----------------------------------------------"
    
    choices = [
      { name: 'Update ticket reservation', value: 1 },
      { name: 'Delete ticket reservation', value: 2 },
      { name: 'Go back to all my ticket reservations', value: 3 }
    ]
    user_input = @prompt.select("Please choose the following", choices, symbols: {marker: '🍿  '})
    case user_input
    when 1
      update_reservation(reservation)
    when 2
      delete_reservation(reservation)
    when 3
      all_reservations(reservation.user)
    end
  end

  def update_reservation(reservation)
    reservation_detail = [
      { name: "Movie: #{reservation.movie.title}", disabled: "👎  can't update" },
      { name: "Time: #{reservation.movie.showtimes}", value: "Time" },
      { name: "Ticket quantity: #{reservation.ticket_quantity}", value: "Ticket quantity"}
    ]
    user_input = @prompt.select('Choose what you would like to update:', reservation_detail, symbols: {marker: '🍿  '})
    case user_input
    when "Showtime"
      time_list = ["12:00 PM", "12:15 PM", "12:30 PM", "12:45 PM", "1:00 PM"]
      new_time = @prompt.select('Choose a new time', time_list, filter: true, symbols: {marker: '🍿  '})
      reservation.update(time: new_time)
    when "Ticket quantity"
      ticket_quantity_list = (1..5).to_a
      new_ticket_quantity = @prompt.select(
        'Change how many tickets you want',
        ticket_quantity_list,
        filter: true,
        symbols: {marker: '🍿  '}
      )
      reservation.update(ticket_quantity: new_ticket_quantity)
    end

    reservation_detail(reservation)
  end

  def delete_reservation(reservation)
    options = [
      { name: 'Y', value: 'y'},
      { name: 'N', value: 'n'}
    ]
    delete_check = @prompt.select("Are you sure you want to delete the reserved ticket(s)?", options, symbols: {marker: '🍿  '})
    case delete_check
    when 'y'
      reservation.delete
      all_reservations(reservation.user)
    when 'n'
      reservation_detail(reservation)
    end
  end
  
  def make_reservation(user)
    movie_list = Movie.all.map(&:title)
    chosen_movie = @prompt.select(
      'Choose your movie',
      movie_list,
      filter: true,
      symbols: {marker: '🍿  '}
      )
      movie = Movie.find_by(title: chosen_movie)
      year_list = [2019, 2020]
      chosen_year = @prompt.select(
        'Please select a year',
        year_list,
        filter: true,
        symbols: {marker: '🍿  '}
        )
        month_list = ["January", "February", "March", "April", "May", "June", "July", "August", "Septemer", "October", "November", "December"]
        chosen_month = @prompt.select(
          'Please select a month',
          month_list,
          filter: true,
          symbols: {marker: '🍿  '}
          )
          day_list = (1..31).to_a
          chosen_day = @prompt.select(
            'Please select a day',
            day_list,
            filter: true,
            symbols: {marker: '🍿  '}
            )
            time_list = ["12:00 PM", "12:15 PM", "12:30 PM", "12:45 PM", "1:00 PM"]
            chosen_time = @prompt.select(
              'Please select a time',
              time_list,
              filter: true,
              symbols: {marker: '🍿  '}
              )
              ticket_quantity_list = (1..5).to_a
              chosen_ticket_quantity = @prompt.select(
                'How many tickets would you like?',
                ticket_quantity_list,
                filter: true,
                symbols: {marker: '🍿  '}
                )
                Reservation.create(
                  user_id: user.id,
                  movie_id: movie.id,
                  # month: chosen_month,
                  # day: chosen_day,
                  # year: chosen_year,
                  # time: chosen_time,
                  ticket_quantity: chosen_ticket_quantity
                  )
                end
                
                
                def exit_app
    puts "See you next time! 👋"
  end

  def run
    greet
    @prompt =  TTY::Prompt.new
    @pastel = Pastel.new
    user = start
    return exit_app if !user.is_a?(User)

    user_input = choices(user)
    while user_input != 3
      case user_input
      when 1
        all_reservations(user)
      when 2
        make_reservation(user)
      end
      user_input = choices(user)
    end
    exit_app
  end

end