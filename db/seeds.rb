User.destroy_all
Movie.destroy_all
<<<<<<< HEAD
Reservation.destroy_all
#Showtime.destroy_all
=======
Ticket.destroy_all
Showtime.destroy_all
Theater.destroy_all
>>>>>>> 99ec6c67186b2860cb44a6bc4c9b1113d35eec15

sasha = User.create(name: "Sasha", email: "sasha@email.com", password: "5555")
eunice = User.create(name: "Eunice", email: "eunice@email.com", password: "1111")
deb = User.create(name: "Deb", email: "deb@email.com", password: "2222")
steven = User.create(name: "Steven", email: "steven@email.com", password: "3333")
justin = User.create(name: "Justin", email: "justin@email.com", password: "4444")

uncut_gems = Movie.create(title: "Uncut Gems", synopsis: "A charismatic jeweler makes a high-stakes bet that could lead to the windfall of a lifetime. In a precarious high-wire act, he must balance business, family and adversaries on all sides in pursuit of the ultimate win.", content_rating: "🔞R")
star_wars = Movie.create(title: "Star Wars: The Rise of Skywalker", synopsis: "The surviving Resistance faces the First Order once more as Rey, Finn and Poe Dameron's journey continues. With the power and knowledge of generations behind them, the final battle commences.", content_rating: "PG-13")
jumanji = Movie.create(title: "Jumanji: The Next Level", synopsis: "When Spencer goes back into the fantastical world of Jumanji, pals Martha, Fridge and Bethany re-enter the game to bring him home. But the game is now broken -- and fighting back. Everything the friends know about Jumanji is about to change, as they soon discover there's more obstacles and more danger to overcome.", content_rating: "PG-13")
cats = Movie.create(title: "Cats", synopsis: "A tribe of cats must decide yearly which one will ascend to the Heaviside Layer and come back to a new life.", content_rating: "PG")
frozen_2 = Movie.create(title: "Frozen 2", synopsis: "Elsa the Snow Queen has an extraordinary gift -- the power to create ice and snow. But no matter how happy she is to be surrounded by the people of Arendelle, Elsa finds herself strangely unsettled. After hearing a mysterious voice call out to her, Elsa travels to the enchanted forests and dark seas beyond her kingdom -- an adventure that soon turns into a journey of self-discovery.", content_rating: "PG")

t1 = Theater.create(name: "AMC")
t2 = Theater.create(name: "Regal")
t3 = Theater.create(name: "Cinepolis")
t4 = Theater.create(name: "ArcLight")
t5 = Theater.create(name: "iPic")

s1 = Showtime.create(movie_id: uncut_gems.id, theater_id: t1.id, time: Time.now)
s2 = Showtime.create(movie_id: uncut_gems.id, theater_id: t1.id, time: 1.hour.from_now)
s3 = Showtime.create(movie_id: uncut_gems.id, theater_id: t2.id, time: 2.hours.from_now)
s4 = Showtime.create(movie_id: uncut_gems.id, theater_id: t4.id, time: 3.days.from_now)
s5 = Showtime.create(movie_id: star_wars.id, theater_id: t1.id, time: 1.hour.from_now)
s6 = Showtime.create(movie_id: star_wars.id, theater_id: t2.id, time: Time.now)
s7 = Showtime.create(movie_id: star_wars.id, theater_id: t2.id, time: 2.days.from_now)
s8 = Showtime.create(movie_id: star_wars.id, theater_id: t3.id, time: 1.day.from_now)
s9 = Showtime.create(movie_id: star_wars.id, theater_id: t5.id, time: 3.hours.from_now)
s10 = Showtime.create(movie_id: jumanji.id, theater_id: t3.id, time: Time.now)
s11 = Showtime.create(movie_id: jumanji.id, theater_id: t5.id, time: 1.hour.from_now)
s12 = Showtime.create(movie_id: jumanji.id, theater_id: t4.id, time: 2.days.from_now)
s13 = Showtime.create(movie_id: jumanji.id, theater_id: t3.id, time: 3.hour.from_now)
s14 = Showtime.create(movie_id: cats.id, theater_id: t2.id, time: 5.hours.from_now)
s15 = Showtime.create(movie_id: cats.id, theater_id: t4.id, time: Time.now)
s16 = Showtime.create(movie_id: cats.id, theater_id: t3.id, time: 1.day.from_now)
s17 = Showtime.create(movie_id: cats.id, theater_id: t4.id, time: 6.hours.from_now)
s18 = Showtime.create(movie_id: frozen_2.id, theater_id: t5.id, time: 1.day.from_now)
s19 = Showtime.create(movie_id: frozen_2.id, theater_id: t1.id, time: 2.hours.from_now)
s20 = Showtime.create(movie_id: frozen_2.id, theater_id: t2.id, time: Time.now)
s21 = Showtime.create(movie_id: frozen_2.id, theater_id: t5.id, time: 1.hour.from_now)

t1 = Ticket.create(showtime_id: s1.id, user_id: sasha.id, ticket_quantity: 2)
t2 = Ticket.create(showtime_id: s2.id, user_id: eunice.id, ticket_quantity: 2)
t3 = Ticket.create(showtime_id: s3.id, user_id: deb.id, ticket_quantity: 3)
t4 = Ticket.create(showtime_id: s4.id, user_id: steven.id, ticket_quantity: 1)
t5 = Ticket.create(showtime_id: s5.id, user_id: justin.id, ticket_quantity: 4)
t6 = Ticket.create(showtime_id: s6.id, user_id: sasha.id, ticket_quantity: 2)
t7 = Ticket.create(showtime_id: s7.id, user_id: sasha.id, ticket_quantity: 3)
t8 = Ticket.create(showtime_id: s8.id, user_id: eunice.id, ticket_quantity: 7)
t9 = Ticket.create(showtime_id: s9.id, user_id: justin.id, ticket_quantity: 5)
t10 = Ticket.create(showtime_id: s9.id, user_id: deb.id, ticket_quantity: 2)
