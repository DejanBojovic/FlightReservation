from flask import Flask, render_template, redirect, url_for, request, session, flash
import mysql.connector
from werkzeug.security import generate_password_hash, check_password_hash

# konektovanje na bazu
mydb = mysql.connector.connect(
	host="localhost",
	user="root",
	password="",
	database="flight-reservation"
)

# inicijalizovanje flask aplikacije
app = Flask(__name__)
# secrete key postaveljn da bi mogao da se korisiti session
app.config['SECRET_KEY'] = 'flight'


# ruta za registrovanje korisnika
@app.route('/signup', methods=['GET', 'POST'])
def signup():
	# ako je metoda POST iskoriscena
	if request.method == "POST":
		# uzimaju se svi podaci iz forme
		username = request.form["username"]
		email = request.form["email"]
		password = request.form["password"]
		confirm_password = request.form["confirm_password"]

		# konektovanje na bazu
		mc = mydb.cursor()
		mc.execute(f"SELECT username FROM Users")
		users = mc.fetchall()

		# ako sve vrednosti postoje i korisnik sa tim imenom vec nije u bazi dolazi do kreiranja korisnika
		if password == confirm_password and username != "" and email != "":
			for user in users:
				if username == user[0]:
					# ako se korisnik satim imenom vec nalazi u bazi onda se novi korisnik ne kreira
					flash("Username already in use!")
					return render_template("signup.html")

			# korisnicke informacije se upisuju u bazu
			mc.execute("INSERT INTO Users (username, password, email) VALUES (%s,%s,%s)", (username, generate_password_hash(password), email))
			mydb.commit()
		else:
			flash("Fill in all the fields!")
			return render_template("signup.html")

		# kreiran korisnik je redirektovan na login stranicu
		return redirect(url_for("login"))

	# ako je metoda GET iskoriscena
	else:
		return render_template('signup.html')


# glavna ruta - root
@app.route('/', methods=["GET", "POST"])
def login():
	if request.method == "POST":
		# ako je post metoda u pitanju sakupljaju se podaci iz forme
		username = request.form["username"]
		password = request.form["password"]

		# konektuje se na bazu i uzimajku se svi korisnici
		mc = mydb.cursor()
		mc.execute("SELECT * FROM Users")
		users = mc.fetchall()

		# za svakog korisnika iz baze se proverava da li se poklapaju username i password
		for user in users:
			if user[1] == username and check_password_hash(user[2], password):
				# kada dodje do poklapanja unetih vrednosti sa onima iz baze taj user se stavlja u session
				session["user"] = user

				# if logged user is amdin redirect him to admin page right away
				if session["user"][1] == "admin":
					return redirect(url_for('admin'))

				return redirect(url_for('home'))

		# ako se ne poklapaju username i passwrod vrsi se sledeca provera
		# ako username ILI password nisu uneseni ta poruka se vraca korisiniku
		if username == "" or password == "":
			flash("Type in username and password!")
			return render_template("login.html")
		# ako su POGRESNO uneseni username i passwrod ta poruka se vraca korisniku
		else:
			flash("Wrong username or password!")
			return render_template("login.html")

	# ako je u pitanju GET metoda onda se vraca stranica korisniku
	else:
		# ako je "user" u session-u to znaci da je i dalje ulogovan tako da se samo redirektuje na "home" stranicu
		if "user" in session:
			return redirect(url_for("home"))

		# ako ga nema u sessionu onda znaci da je izlogovan i prosledjuje mu je "login" stanica
		return render_template('login.html')


# ruta povezana sa "sign out" dugmetom
@app.route('/logout')
def logout():
	# kada se klikne na sign out dugme user, users i flights se izbacuju iz sesije i vraca na login stranicu
	session.pop("user", None)
	session.pop("users", None)
	session.pop("flights", None)
	flash("Logged out successfully!")
	return redirect(url_for("login"))


# na ovoj ruti se vrsi pretraga letova
@app.route('/home', methods=["GET", "POST"])
def home():
	if request.method == "POST":
		# sakupljaju se svi podaci iz forme
		direction = request.form["direction"]
		f = request.form["from"]
		t = request.form["to"]
		d = request.form["date"]
		passengers = request.form["passengers"]

		# uzimaju se svi letovi
		mc = mydb.cursor()
		mc.execute("SELECT * FROM Flights")
		flights = mc.fetchall()

		searched_flights = []

		# vrsi se pretraga letova koji sipunjavaju sve kriterijume iz forme
		for flight in flights:
			if flight[1] == direction and flight[2] == f and flight[3] == t and d in str(flight[4]) \
				and int(flight[5]) >= int(passengers):
				# odabrani letovi sa apenduju u listu x i prosledjuju stranici
				searched_flights.append(flight)

		if len(searched_flights) == 0:
			flash("No flight matches the search!")
			return render_template("home.html", user=session["user"])

		return render_template("home.html", user=session["user"], f=searched_flights)
	else:
		if "user" in session:
			user = session["user"]
			return render_template('home.html', user=user)
		else:
			flash("You need to log in first!")
			return redirect(url_for("login"))


# ruta kojoj se prosledjuje id leta, rezervise se let i vraca se nazad na home stranicu
@app.route('/reservation/<id>')
def reservation(id):
	if "user" in session:
		user = session["user"]
		mc = mydb.cursor()
		# u tabelu reservations se unose id trenutnog usera i i leta koji je prosledjen
		mc.execute("INSERT INTO Reservations (userID, flightID) VALUES (%s, %s)", (user[0], id))
		mydb.commit()

		# nakon unetih informacija user se redirektuje na 'user' stranicu
		return redirect(url_for('user'))


# brisanje rezervacije sa prosledjenim id-jem
@app.route('/delete_reservation/<id>')
def delete_reservation(id):
	if "user" in session:
		user = session["user"]

		mc = mydb.cursor()
		# iz tabele reservations se brise kolona u kojoj je id trenutnog usera i prosledjeni id leta koji se brise
		mc.execute(f"DELETE FROM Reservations WHERE userID = '{user[0]}' AND flightID = '{id}'")
		mydb.commit()

		return redirect(url_for('user'))


@app.route('/user')
def user():
	if "user" in session:
		# provera da li je admin "user"
		if session["user"][1] == "admin":
			return redirect(url_for("admin"))

		user = session["user"]

		mc = mydb.cursor()
		mc.execute("SELECT * FROM Flights")
		flights = mc.fetchall()

		mc.execute("SELECT * FROM Reservations")
		reservatins = mc.fetchall()

		found = []
		current_user = []

		# iz reservations tabele se izvalce sve kolone koje sadrze trenutnog korisnika
		for r in reservatins:
			if r[1] == user[0]:
				current_user.append(r)

		# iz tabele flights se izvlace svi letovi koje je rezervisao trenutni korisnik
		for flight in flights:
			for c in current_user:
				if c[2] == flight[0]:
					found.append(flight)

		# ukupna cena karata
		full_price = 0
		for flight in found:
			full_price += flight[6]

		return render_template('user.html', user=user, r=reservatins, c=current_user, f=found, full_price=full_price)
	else:
		flash("You need to log in first!")
		return redirect(url_for("login"))


@app.route('/admin')
def admin():
	# ako korisnik nije ulogovan i pokusa da pristupi admin panelu vratiti ga na login stranicu
	if "user" not in session:
		flash("You can't access admin panel!")
		return redirect(url_for("login"))

	# uzimaju se svi podaci iz baze kako bi se prikazali u admin panelu
	if session["user"][1] == "admin":
		mc = mydb.cursor()
		mc.execute("SELECT * FROM Users")
		users = mc.fetchall()
		session["users"] = users

		mc.execute("SELECT * FROM Flights")
		flights = mc.fetchall()
		session["flights"] = flights

		mc.execute("SELECT * FROM Reservations")
		reservations = mc.fetchall()

		all_res = []

		for res in reservations:
			for us in users:
				if us[0] == res[1]:
					for fl in flights:
						if fl[0] == res[2]:
							all_res.append([us[1], fl])

		return render_template("admin.html", user=session["user"], f=flights, u=users, r=all_res)
	else:
		# ako ulogovani korisnik pokusa da pristupi admin panelu redirektovati ga na user stranicu
		return redirect(url_for('user'))


# promena cene karte
@app.route('/price_change/<id>', methods=["GET", "POST"])
def price_change(id):
	if request.method == "POST":
		price = float(request.form["price"])

		mc = mydb.cursor()
		mc.execute(f"UPDATE Flights SET price='{price}' WHERE flightID='{id}'")
		mydb.commit()

		return redirect(url_for('admin'))
	else:
		flights = session["flights"]

		for flight in flights:
			if int(flight[0]) == int(id):
				return render_template("price_change.html", flight=flight, user=session["user"])


@app.route('/add_flight', methods=["GET", "POST"])
def add_flight():
	if request.method == "POST":
		direction = request.form["direction"]
		f = request.form["from"]
		t = request.form["to"]
		d = request.form["date"]
		passengers = request.form["passengers"]
		price = request.form["price"]

		if direction != "" and f != "" and t != "" and d != "" and int(passengers) > 0 and float(price) > 0:
			mc = mydb.cursor()
			mc.execute("INSERT INTO Flights (direction, start, end, d, passengers, price) VALUES (%s,%s,%s,%s,%s,%s)",
						(direction, f, t, d, passengers, price))
			mydb.commit()

			return redirect(url_for('admin'))
		else:
			flash("You need to fill all the info!")
			return redirect(url_for('add_flight'))

	else:
		return render_template("add_flight.html", user=session["user"])


# brisanje leta iz admin panela
@app.route('/delete_flight/<id>')
def delete_flight(id):
	mc = mydb.cursor()
	mc.execute(f"DELETE FROM Flights WHERE flightID = '{id}'")
	mydb.commit()

	return redirect(url_for('admin'))


if __name__ == '__main__':
	app.run(debug=True)
