class CommandLineInterface

  def greet
    puts "Welcome to Movie Reservations! 🎬  🍿"
  end

  def start
    prompt =  TTY::Prompt.new 
    
    choices = [
      {name: 'Login', value: 1},
      {name: 'Create a username', value: 2},
      {name: 'Exit', value: 3}
    ]
  
    user_input = prompt.select('What would you like to do?', choices) do |menu|
      menu.choice 'Login', -> do
        user_email_input = prompt.ask("Email:")
        user = User.find_by(email: user_email_input)
        user_password_input = prompt.mask("Password:")
        if user.password != user_password_input
          puts "Wrong password, please try again."
          attempt = 0
          while attempt < 3
            user_password_input = prompt.mask("Password:")
            if user.password == user_password_input
              puts "hello"
              # can delete hello
              back
              # can hit another method
              break
            end
            attempt += 1
            puts "Wrong password, please try again."
          end
        end
        user
      end
      menu.choice 'Create an account', -> do
        user_name_input = prompt.ask("Please enter your name:")
        user_email_input = prompt.ask("Please enter your email address:")
        user_password_input = prompt.mask("Please create a password:")
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

  def exit_app
    puts "See you next time! 👋"
  end

  def back
    puts "backkk"
  end

  def run
    greet
    start
  end

end