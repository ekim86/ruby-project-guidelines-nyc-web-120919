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
  
    user_input = @prompt.select(
      'What would you like to do?',
        choices,
        cycle: true,
        symbols: {marker: '🍿'}
      ) do |menu|
      menu.choice 'Login', -> { login }
      menu.choice 'Create an account', -> { create_account }
      menu.choice 'Exit', -> do
        exit_app
      end
    end
  end

  def login
    user_email_input = @prompt.ask("Email:")
    user = User.find_by(email: user_email_input.downcase)
    attempt = 1
    while attempt < 4
      user_password_input = @prompt.mask("Password:")
      if user.password == user_password_input
        puts @pastel.bright_cyan(@font.write("Hi #{user.name}"))
        break
      elsif user.password != user_password_input 
        @prompt.error "Wrong password, please try again."
        user = nil if attempt == 3
      end
      attempt += 1
    end
    user
  end

  def create_account
      user_name_input = @prompt.ask("Please enter your name:")
      user_email_input = @prompt.ask("Please enter your email address:")
      user_password_input = @prompt.mask("Please create a password:")
      User.create(
        name: user_name_input,
        email: user_email_input,
        password: user_password_input
      )
  end

  def choices(user)
    
    choices = [
      {name: 'See all reserved tickets', value: 1},
      {name: 'Reserve a ticket', value: 2},
      {name: 'Exit', value: 3}
    ]

    user_input = @prompt.select('Please select a prompt', choices, cycle: true, symbols: {marker: '🍿'})
  end

  def all_tickets(user)
    # binding.pry
    user_tickets = user.tickets.reload
    tickets = user_tickets.map do |ticket|
      {
        name: "🙌  You reserved #{ticket.ticket_quantity} ticket(s) for #{ticket.movie.title}\n-----------------------------------------------",
        value: ticket.id
      }
    end
    tickets << { name: 'Go Back', value: 0}

    selected_ticket_id = @prompt.select('Select to see more details', tickets, cycle: true, symbols: {marker: '🍿'})

    if selected_ticket_id > 0
      selected_ticket = Ticket.find(selected_ticket_id)
      ticket_detail(selected_ticket)
    end
  end

  def ticket_detail(ticket)
    puts "-----------------------------------------------"
    print "🎟  You have "
    print @pastel.bright_cyan("#{ticket.ticket_quantity} ticket(s) ")
    print "reserved at "
    puts @pastel.bright_cyan("#{ticket.theater.name}")
    print "for "
    print @pastel.bright_cyan("#{ticket.movie.title} ")
    print "on "
    print @pastel.bright_cyan("#{ticket.showtime.time.strftime("%A, %m/%d/%y")} ")
    print "at "
    puts @pastel.bright_cyan("#{ticket.showtime.time.strftime'%I:%M%p'}")
    puts "-----------------------------------------------"
    
    choices = [
      { name: 'Update ticket', value: 1 },
      { name: 'Remove ticket', value: 2 },
      { name: 'Go back to all my movie tickets', value: 3 }
    ]
    user_input = @prompt.select("Please choose the following", choices, cycle: true, symbols: {marker: '🍿'})
    case user_input
    when 1
      update_ticket(ticket)
    when 2
      delete_ticket(ticket)
    when 3
      all_tickets(ticket.user)
    end
  end

  def update_ticket(ticket)
    ticket_detail = [
      { name: "Movie: #{ticket.movie.title}", disabled: "🚫  can't update 🚫" },
      { name: "Date: #{ticket.showtime.time.strftime("%m/%d/%y")}", value: "Showtime" },
      { name: "Time: #{ticket.showtime.time.strftime'%I:%M%p'}", value: "Showtime" },
      { name: "Theater: #{ticket.theater.name}", value: "Theater", disabled: "🚫  can't update 🚫" },
      { name: "Ticket quantity: #{ticket.ticket_quantity}", value: "Ticket quantity"}
    ]
  
    user_input = @prompt.select('Choose what you would like to update:', ticket_detail, cycle: true, symbols: {marker: '🍿'})
    case user_input
    when "Showtime"
      # time_list = ticket.movie.showtimes.where(theater: ticket.theater)
      time_list = ticket.theater.showtimes.where(movie: ticket.movie).map(&:time).uniq
      # binding.pry
      new_time = @prompt.select("Choose a new time", time_list, cycle: true, symbols: {marker: '🍿'})
      ticket.showtime.update(time: new_time)
    when "Ticket quantity"
      ticket_quantity_list = (1..9).to_a
      new_ticket_quantity = @prompt.select(
        'Change how many tickets you want',
        ticket_quantity_list,
        cycle: true,
        symbols: {marker: '🍿'}
      )
      ticket.update(ticket_quantity: new_ticket_quantity)
    end

    ticket_detail(ticket)
  end

  def delete_ticket(ticket)
    options = [
      { name: 'Y', value: 'y'},
      { name: 'N', value: 'n'}
    ]
    delete_check = @prompt.select(
      "Are you sure you want to delete the reserved ticket(s)?",
      options,
      cycle: true,
      symbols: {marker: '🍿'}
    )
    case delete_check
    when 'y'
      ticket.delete
      all_tickets(ticket.user)
    when 'n'
      ticket_detail(ticket)
    end
  end
  
  def make_ticket(user)
    movie_list = Movie.all.map(&:title)
    chosen_movie = @prompt.select(
      'Choose your movie',
      movie_list,
      filter: true,
      cycle: true,
      symbols: {marker: '🍿'}
    )
    movie = Movie.find_by(title: chosen_movie)
    theater_list = movie.theaters.map(&:name).uniq
    chosen_theater = @prompt.select(
      'Choose your theater',
      theater_list,
      filter: true,
      cycle: true,
      symbols: {marker: '🍿'}
    )
    time_list = movie.showtimes.map(&:time)
    chosen_time = @prompt.select(
      'Choose your date and time',
      time_list,
      filter: true,
      symbols: {marker: '🍿'}
    )
    showtime = movie.showtimes.find_by(time: chosen_time)
    ticket_quantity_list = (1..9).to_a
    chosen_ticket_quantity = @prompt.select(
      'How many tickets would you like?',
      ticket_quantity_list,
      filter: true,
      symbols: {marker: '🍿'}
    )
    Ticket.create(
      user_id: user.id,
      showtime_id: showtime.id,
      ticket_quantity: chosen_ticket_quantity
    )
  end
                
                
  def exit_app
    puts "See you next time! 👋"
    puts @pastel.bright_cyan(@font.write("Bye"))
  end

  def run
    greet
    # @prompt =  TTY::Prompt.new
    @prompt = TTY::Prompt.new(active_color: :bright_magenta)
    @pastel = Pastel.new
    @font = TTY::Font.new(:starwars)
    user = start
    return exit_app if !user.is_a?(User)

    user_input = choices(user)
    while user_input != 3
      case user_input
      when 1
        all_tickets(user)
      when 2
        make_ticket(user)
      end
      user_input = choices(user)
    end
    exit_app
  end

end