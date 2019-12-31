User.destroy_all
Movie.destroy_all
Reservation.destroy_all
Showtime.destroy_all

sasha = User.create(name: "Sasha", email: "sasha@email.com", password: "5555")
eunice = User.create(name: "Eunice", email: "eunice@email.com", password: "1111")
deb = User.create(name: "Deb", email: "deb@email.com", password: "2222")
steven = User.create(name: "Steven", email: "steven@email.com", password: "3333")
justin = User.create(name: "Justin", email: "justin@email.com", password: "4444")

# uncut_gems_time= Showtime.create(time: )
# star_wars_time = Showtime.create(name: "Eunice", email: "eunice@email.com", password: "1111")
# jumanji_time = Showtime.create(name: "Deb", email: "deb@email.com", password: "2222")
# cats_time = Showtime.create(name: "Steven", email: "steven@email.com", password: "3333")
# frozen_2_time = Showtime.create(name: "Justin", email: "justin@email.com", password: "4444")

uncut_gems = Movie.create(title: "Uncut Gems", synopsis: "A charismatic jeweler makes a high-stakes bet that could lead to the windfall of a lifetime. In a precarious high-wire act, he must balance business, family and adversaries on all sides in pursuit of the ultimate win.", content_rating: "🔞R")
star_wars = Movie.create(title: "Star Wars: The Rise of Skywalker", synopsis: "The surviving Resistance faces the First Order once more as Rey, Finn and Poe Dameron's journey continues. With the power and knowledge of generations behind them, the final battle commences.", content_rating: "PG-13")
jumanji = Movie.create(title: "Jumanji: The Next Level", synopsis: "When Spencer goes back into the fantastical world of Jumanji, pals Martha, Fridge and Bethany re-enter the game to bring him home. But the game is now broken -- and fighting back. Everything the friends know about Jumanji is about to change, as they soon discover there's more obstacles and more danger to overcome.", content_rating: "PG-13")
cats = Movie.create(title: "Cats", synopsis: "A tribe of cats must decide yearly which one will ascend to the Heaviside Layer and come back to a new life.", content_rating: "PG")
frozen_2 = Movie.create(title: "Frozen 2", synopsis: "Elsa the Snow Queen has an extraordinary gift -- the power to create ice and snow. But no matter how happy she is to be surrounded by the people of Arendelle, Elsa finds herself strangely unsettled. After hearing a mysterious voice call out to her, Elsa travels to the enchanted forests and dark seas beyond her kingdom -- an adventure that soon turns into a journey of self-discovery.", content_rating: "PG")

res_1 = Reservation.create(user_id: sasha.id, movie_id: uncut_gems.id, ticket_quantity: 2)
res_2 = Reservation.create(user_id: eunice.id, movie_id: uncut_gems.id, ticket_quantity: 2)
res_3 = Reservation.create(user_id: deb.id, movie_id: frozen_2.id, ticket_quantity: 3)
res_4 = Reservation.create(user_id: steven.id, movie_id: star_wars.id, ticket_quantity: 1)
res_5 = Reservation.create(user_id: justin.id, movie_id: jumanji.id, ticket_quantity: 4)
res_6 = Reservation.create(user_id: sasha.id, movie_id: cats.id, ticket_quantity: 2)
res_7 = Reservation.create(user_id: sasha.id, movie_id: cats.id, ticket_quantity: 3)
res_8 = Reservation.create(user_id: sasha.id, movie_id: frozen_2.id, ticket_quantity: 1)
res_9 = Reservation.create(user_id: eunice.id, movie_id: star_wars.id, ticket_quantity: 5)
res_10 = Reservation.create(user_id: eunice.id, movie_id: uncut_gems.id, ticket_quantity: 2)
