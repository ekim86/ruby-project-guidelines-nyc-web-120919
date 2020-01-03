class CommandLineInterface

  def greet
    puts "Welcome to Movie Reservations! 🎬  🍿"
  end

  def start_menu
    @prompt.select("What Would You Like To Do?") do |menu|
      menu.choice "Login", -> { login_menu }
      menu.choice "Create an account", -> { create_account_menu }
      menu.choice "Exit", -> { exit_app }

  def login_menu
    user_email_input = @prompt.ask("Email:")
    user = User.find_by(email: user_email_input)
    user_password_input = @prompt.mask("Password:")
    menu.choice "Go Back", -> { start_menu }  
        if user.password != user_password_input
          puts "Wrong password, please try again."
          attempt = 0
          while attempt < 2
            user_password_input = @prompt.mask("Password:")
            if user.password == user_password_input
              puts pastel.bright_magenta("Hello #{user.name.capitalize}")
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

  def create_account_menu
    user_name_input = @prompt.ask("Please enter your name:")
    user_email_input = @prompt.ask("Please enter your email address:")
    user_password_input = @prompt.mask("Please create a password:")
        User.create(
          name: user_name_input,
          email: user_email_input,
          password: user_password_input
        )
        menu.choice "Go Back", -> { start_menu }  
  end