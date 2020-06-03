Instrukcja:

1.Zaloguj się do mysql jako root, bądź użytkownik z możliwością dodawania nowych użytkowników do bazy i zaimportuj schemat z pliku Database.

2.Upewnij się że baza danych działa na adresie localhost na porcie 3306. Jeżeli nie możesz uruchomić bazę danych na podanym sockecie lub zmienić plik App.config na wybrane przez siebie dane.

3.Uruchom aplikację i zarejestruj się jako nowy użytkownik.



Zapytania SQL użyte w Aplikacji ComputerShop:

INSERT:

1.
Plik:	ComputerShop/FormViews/FKoszyk.cs 	 wiersz: 138
Zapytanie:	"INSERT INTO orders(UserID, Order_number, Order_date, ProductID, Product_number, Delivery) VALUES(" + UserId + "," + orderNumber + ",'" + orderDate + "'," + item + ", 1,'" + checkedListBox1.CheckedItems[0].ToString() + "')"
Parametry:	UserId, ordernumber, orderdate, item, checkedListBox1
Komentarz: Zapytanie pozwala umieścić w bazie w tabeli orders nowe zamówienie. W tej tabeli przetrzymywany jest każdy zamówiony produkt razem z ID użytkownika oraz numerem zamówienia, dzięki czemu wiemy do którego zamówienia należy dany produkt .

2.
Plik: 	ComputerShop/FormViews/AuthenticationModel.cs 	
Wiersze: 72
Zapytania:
"INSERT INTO addresses(Street,Number,City,Post_code) VALUES('" + Street.Trim() + "','" + HouseNumber.Trim() + "','" + City.Trim() + "','" + PostCode.Trim() + "'  )"

Parametry:	
Street.Trim() - ulica wprowadzona przez użytkownika
HouseNumber.Trim() - numer domu wprowadzony przez użytkownika  
City.Trim() - miasto wprowadzone przez użytkownika
PostCode.Trim() - kod pocztowy wprowadzony przez użytkownika 

Komentarz:	Zapytanie ma na celu wprowadzenia do bazy danych nowego adresu rejestrującego się użytkownika 











3.
Plik: 	ComputerShop/FormViews/AuthenticationModel.cs 	
Wiersze: 80
Zapytania:
"INSERT INTO user(name, surname, addressid, login, password, email, phone_number, is_a_client, is_a_company_client) VALUES('" + Name.Trim() + "','" + Surname.Trim() + "',@addressId,'" + Login.Trim() + "','" + Password.Trim() + "','" + Email.Trim() + "','" + PhoneNumber.Trim() + "',1,0)"

Parametry:	
Name.Trim() - imię wprowadzone przez użytkownika 
Surname.Trim() - nazwisko wprowadzone przez użytkownika 
Login.Trim() - login wprowadzony przez użytkownika
Password.Trim() - hasło wprowadzone przez użytkownika 
Email.Trim() - e mail wprowadzony przez użytkownika 
PhoneNumber.Trim() - numer telefonu wprowadzony przez użytkownika 

Komentarz:	Zapytanie ma na celu wstawienie do bazy danych danych wprowadzonych przez użytkownika przy rejestracji 






SELECT:

1.
Plik: 	ComputerShop/FormViews/FComputersMain.cs 	 wiersz: 34
Zapytanie:	"SELECT DISTINCT products.Brand, products.Price, products.Rating FROM products INNER JOIN specyfications.s on products.specyficationsID = s.ID INNER JOIN rams r on s.RAM = r.ID WHERE CPU IS NOT NULL AND Power_supply_unit IS NOT NULL";
Parametry:	 Brak
Komentarz:	To zapytanie odpowiada za załadowanie wszystkich komputerów znajdujących się w bazie do DataGridView - czyli widoku rekordów bazy danych w aplikacji. Wyświetlone są odpowiednio: Firma, Cena, Ocena produktu.



2.
Plik: 	ComputerShop/FormViews/FComputersMain.cs 	 wiersz: 51
Zapytanie:	"SELECT CPU, GPU, RAM, Hard_drive, power_supply_unit, mainboard FROM specyfications INNER JOIN products p on specyfications.ID = p.specyficationsID
WHERE Brand = '" + row.Cells["Brand"].Value.ToString() + "' AND Price = " + row.Cells["Price"].Value + " AND mainboard IS NOT NULL";
Parametry:	row.Cells[“Brand”].Value, row.Cells["Price"].Value
Komentarz:	Zapytanie zostało wykorzystane do zebrana z tabeli informacji o podzespołach konkretnego komputera. Zebrane zostaną ID konkretnych podzespołów z tabeli specyfikacji. Na końcu zapytania dodano ograniczenie że mainboards nie może mieć wartości null. Zostało to dodane żeby odróżnić laptopy od komputerów. Laptopy nie posiadają danych o płycie głównej ani zasilaniu.

3.
Plik: 	ComputerShop/FormViews/FComputersMain.cs 	 wiersz: 67
Zapytanie:	"SELECT cpus.Name FROM cpus WHERE ID = " + specyfications[0];
Parametry:	specyfications[0]
Komentarz:	Zapytanie pobiera nazwę modelu podzespołu z tabeli cpus szukając po numerze ID.

4.
Plik: 	ComputerShop/FormViews/FComputersMain.cs 	 wiersz: 71
Zapytanie:	"SELECT gpus.Name FROM gpus WHERE ID = " + specyfications[1];
Parametry:	specyfications[1]
Komentarz:	Zapytanie pobiera nazwę modelu podzespołu z tabeli gpus szukając po numerze ID.

5.
Plik: 	ComputerShop/FormViews/FComputersMain.cs 	 wiersz: 75
Zapytanie:	"SELECT rams.RAM_capacity FROM rams WHERE ID = " + specyfications[2];
Parametry:	specyfications[2]
Komentarz:	Zapytanie pobiera nazwę modelu podzespołu z tabeli rams szukając po numerze ID.

6.
Plik: 	ComputerShop/FormViews/FComputersMain.cs 	 wiersz: 79
Zapytanie:	"SELECT hard_drives.capacity FROM hard_drives WHERE ID = " + specyfications[3];
Parametry:	specyfications[3]
Komentarz:	Zapytanie pobiera nazwę modelu podzespołu z tabeli hard_drives szukając po numerze ID.




7.
Plik: 	ComputerShop/FormViews/FComputersMain.cs 	 wiersz: 83
Zapytanie:	"SELECT power_supply_units.DC_output FROM power_supply_units WHERE ID = " + specyfications[4]

Parametry:	specyfications[4]
Komentarz:	Zapytanie pobiera nazwę modelu podzespołu z tabeli power_supply_units szukając po numerze ID.

8.
Plik: 	ComputerShop/FormViews/FComputersMain.cs 	 wiersz: 87
Zapytanie:	"SELECT mainboards.Name FROM mainboards WHERE ID = " + specyfications[5]

Parametry:	specyfications[5]
Komentarz:	Zapytanie pobiera nazwę modelu podzespołu z tabeli mainboards szukając po numerze ID.

9.
Plik: 	ComputerShop/FormViews/FComputersMain.cs 	 wiersz: 95
Zapytanie:	"Select ID From products WHERE Brand = '" + brand + "' AND Rating = " + (int)rating + "." + tempRating + " AND Price = " + temptPrice;

Parametry:	brand, rating, tempRatin, temptPrice
Komentarz:	Zapytanie to pobiera numer ID Komputera wyszukując go w tabeli po nazwie, ocenie i cenie. 

10.
Plik: 	ComputerShop/FormViews/FKoszyk.cs 	 wiersz: 58
Zapytanie:	string queryID = "SELECT ID FROM products WHERE Price = " + temptPrice + " AND Brand = '" + brand + "' AND Rating = " + (int)rating + "." + tempRating;

Parametry:	temptprice, brand, rating, temptRating
Komentarz:	Zapytanie ma na celu pobranie Numeru ID z tabeli produkty. Ta operacja będzie wykonana po kliknięciu w jakiś produkt w DataGridView z poziomu aplikacji.

11.
Plik: 	ComputerShop/FormViews/FKoszyk.cs 	 wiersz: 106
Zapytanie:	string queryordernumber = "SELECT MAX(Order_number) FROM orders";

Parametry:	Brak
Komentarz:	Zapytanie ma na celu zwrócenie maksymalnej wartości numeru zamówienia. Aby nowe zamówienie miało przypisane następny niepowtarzający się numer.



12.
Plik: 	ComputerShop/FormViews/FKoszyk.cs 	 wiersz: 130
Zapytanie:	"Select Price FROM products Where ID = '" + item + "' "

Parametry:	item
Komentarz:	Zapytanie ma na celu zwrócenie ceny produktu z tabeli products na podstawie numeru ID produktu.

13.
Plik: 	ComputerShop/FormViews/FKoszyk.cs 	 wiersz: 186
Zapytanie:	"Select Brand FROM products Where ID = " + productId 

Parametry:	productId
Komentarz:	Zapytanie ma na celu zwrócenie nazwy produktu z tabeli products na podstawie numeru ID produktu.

14.
Plik: 	ComputerShop/FormViews/FKoszyk.cs 	 wiersz: 197
Zapytanie:	"Select Category FROM products Where ID = " + productId + " "

Parametry:	productId
Komentarz:	Zapytanie ma na celu zwrócenie nazwy kategorii produktu z tabeli products na podstawie numeru ID produktu.

15 + 9.
Plik: 	ComputerShop/FormViews/FKoszyk.cs 	 wiersz: 207-242
Zapytanie:	"SELECT power_supply_units.Name FROM mainboards INNER JOIN specyfications ON specyfications.Power_supply_unit = power_supply_units.ID INNER JOIN products on products.ID = specyfications.ID WHERE CPU IS NULL"

Parametry:	brak
Komentarz:	Zapytanie ma na celu zwrócenie nazwy  danego produktu. W wierszach 207-242 zostało napisane 9 różnych zapytań, które zostaną użyte w zależności od nazwy kategorii, która została zwrócona zapytaniem nr 14. Zapytania znajdują się w switchu.

16.
Plik: 	ComputerShop/FormViews/FKoszyk.cs 	 wiersz: 258
Zapytanie:	string queryPrice = "Select Price FROM products Where ID = " + productId

Parametry:	productID
Komentarz:	Zapytanie ma na celu zwrócenie ceny produktu z tabeli products na podstawie numeru ID produktu.




17.
Plik: 	ComputerShop/FormViews/FKoszyk.cs 	 wiersz: 267
Zapytanie:	"Select Rating FROM products Where ID = " + productId

Parametry:	productID
Komentarz:	Zapytanie ma na celu zwrócenie oceny produktu z tabeli products na podstawie numeru ID produktu.

18.
Plik: 	ComputerShop/FormViews/FLaptopsMain.cs 	 wiersz: 46
Zapytanie:	"SELECT DISTINCT products.Brand, products.Price, products.Rating FROM products INNER JOIN specyfications s on products.specyficationsID = s.ID INNER JOIN rams r on s.RAM = r.ID WHERE CPU IS NOT NULL AND Power_supply_unit IS NULL";

Parametry:	Brak
Komentarz:	Zapytanie podobne do zapytania numer 2. Ma za zadanie pobranie wszystkich rekordów laptopów z tabeli products. Laptopy charakteryzują się tym (w naszym sklepie) że nie mają zasilania. Więc od komputerów stacjonarnych odróżnia ich wartość ID zasilacza = null i płyty głównej = null.

19.
Plik: 	ComputerShop/FormViews/FLaptopsMain.cs 	 wiersz: 64
Zapytanie:	string selectSpecyfications = "SELECT CPU, GPU, RAM, Hard_drive, Screen FROM specyfications  INNER JOIN products p on specyfications.ID = p.specyficationsID
WHERE Brand = '" + row.Cells["Brand"].Value.ToString() + "' AND Price = " + row.Cells["Price"].Value;


Parametry:	row.Cells["Brand"].Value, row.Cells["Price"].Value
Komentarz:	Zapytanie analogiczne do zapytania nr 1.Tzn pobierane są informacje o numerach ID podzespołów po kliknięciu w dany rekord w DataGridView z poziomu aplikacji.


20.
Plik: 	ComputerShop/FormViews/FLaptopsMain.cs 	 wiersz: 79
Zapytanie:	"SELECT cpus.Name FROM cpus WHERE ID = " + specyfications[0]


Parametry:	specyfications[0]
Komentarz:	Zapytanie ma na celu pobranie z bazy nazwę produktu z tabeli cpus po konkretnym numerze ID (productID)





21.
Plik: 	ComputerShop/FormViews/FLaptopsMain.cs 	 wiersz: 83
Zapytanie:	"SELECT gpus.Name FROM gpus WHERE ID = " + specyfications[1]


Parametry:	specyfications[1]
Komentarz:	Zapytanie ma na celu pobranie z bazy nazwę produktu z tabeli gpus po konkretnym numerze ID (productID)

22.
Plik: 	ComputerShop/FormViews/FLaptopsMain.cs 	 wiersz: 87
Zapytanie:	"SELECT rams.RAM_capacity FROM rams WHERE ID = " + specyfications[2]


Parametry:	specyfications[2]
Komentarz:	Zapytanie ma na celu pobranie z bazy nazwę produktu z tabeli rams po konkretnym numerze ID (productID)

23.
Plik: 	ComputerShop/FormViews/FLaptopsMain.cs 	 wiersz: 91
Zapytanie:	"SELECT hard_drives.capacity FROM hard_drives WHERE ID = " + specyfications[3]


Parametry:	specyfications[3]
Komentarz:	Zapytanie ma na celu pobranie z bazy nazwę produktu z tabeli hard_drives po konkretnym numerze ID (productID)

24.
Plik: 	ComputerShop/FormViews/FLaptopsMain.cs 	 wiersz: 95
Zapytanie:	"SELECT screens.Display_size FROM screens WHERE ID = " + specyfications[4]


Parametry:	specyfications[4]
Komentarz:	Zapytanie ma na celu pobranie z bazy nazwę produktu z tabeli screens po konkretnym numerze ID (productID)









25.
Plik: 	ComputerShop/FormViews/FLaptopsMain.cs 	 wiersz: 103
Zapytanie:	"Select ID From products WHERE Brand = '" + brand + "' AND Rating = " + (int)rating + "."+ tempRating+ " AND Price=" + temptPrice


Parametry:	brand, rating, tempRating, temptPrice
Komentarz:	Zapytanie ma na celu pobranie z bazy numeru ID danego laptopa wyszukując go za pomocą nazwy marki, oceny i ceny produktu.

26.
Plik: 	ComputerShop/FormViews/FMain.cs 	 wiersz: 223
Zapytanie:	"SELECT Name FROM user WHERE ID=@userid "


Parametry:	@userID
Komentarz:	Zapytanie to pobiera nazwę użytkownika po numerze ID użytkownika z tabeli user.

27.
Plik: 	ComputerShop/FormViews/FMain.cs 	 wiersz: 229
Zapytanie:	"SELECT Surname FROM user WHERE ID=@userid"


Parametry:	@userID
Komentarz:	Zapytanie to pobiera nazwisko użytkownika po numerze ID użytkownika z tabeli user.

28.
Plik: 	ComputerShop/FormViews/FMain.cs 	 wiersz: 234
Zapytanie:	"SELECT Login FROM user WHERE ID=@userid"


Parametry:	@userID
Komentarz:	Zapytanie to pobiera login użytkownika po numerze ID użytkownika z tabeli user.

29.
Plik: 	ComputerShop/FormViews/FMain.cs 	 wiersz: 239
Zapytanie:	"SELECT Password FROM user WHERE ID=@userid"


Parametry:	@userID
Komentarz:	Zapytanie to pobiera hasło użytkownika po numerze ID użytkownika z tabeli user.

30.
Plik: 	ComputerShop/FormViews/FMain.cs 	 wiersz: 244
Zapytanie:	"SELECT Email FROM user WHERE ID=@userid""


Parametry:	@userID
Komentarz:	Zapytanie to pobiera email użytkownika po numerze ID użytkownika z tabeli user.

31.
Plik: 	ComputerShop/FormViews/FMain.cs 	 wiersz: 249
Zapytanie:	"SELECT Phone_number FROM user WHERE ID=@userid""


Parametry:	@userID
Komentarz:	Zapytanie to pobiera numer telefonu użytkownika po numerze ID użytkownika z tabeli user.

32.
Plik: 	ComputerShop/FormViews/FMain.cs 	 wiersz: 254
Zapytanie:	"SELECT Is_a_company_client FROM user WHERE ID=@userid"


Parametry:	@userID
Komentarz:	Zapytanie to pobiera informacje o tym czy użytkownik jest clientem po numerze ID użytkownika z tabeli user.

33.
Plik: 	ComputerShop/FormViews/FMain.cs 	 wiersz: 259
Zapytanie:	"SELECT AddressID FROM user WHERE ID=@userid"


Parametry:	@userID
Komentarz:	Zapytanie to pobiera informacje o ID adressu użytkownika po numerze ID użytkownika z tabeli user. 

34.
Plik: 	ComputerShop/FormViews/FMain.cs 	 wiersz: 264
Zapytanie:	"SELECT Street FROM addresses WHERE ID = @addressid"


Parametry:	@addressid
Komentarz:	Zapytanie to pobiera informacje o ulicy użytkownika po numerze ID adresu z tabeli addresses. 


35.
Plik: 	ComputerShop/FormViews/FMain.cs 	 wiersz: 269
Zapytanie:	"SELECT Number FROM addresses WHERE ID = @addressid"


Parametry:	@addressid
Komentarz:	Zapytanie to pobiera informacje o numerze domu użytkownika po numerze ID adresu z tabeli addresses. 

36.
Plik: 	ComputerShop/FormViews/FMain.cs 	 wiersz: 274
Zapytanie:	"SELECT City FROM addresses WHERE ID = @addressid"


Parametry:	@addressid
Komentarz:	Zapytanie to pobiera informacje o mieście użytkownika po numerze ID adresu z tabeli addresses. 

37.
Plik: 	ComputerShop/FormViews/FMain.cs 	 wiersz: 279
Zapytanie:	"SELECT Post_code FROM addresses WHERE ID = @addressid"


Parametry:	@addressid
Komentarz:	Zapytanie to pobiera informacje o kodzie pocztowym użytkownika po numerze ID adresu z tabeli addresses. 




















37.
Pliki: 	
ComputerShop/FormViews/FProductsCpuMain.cs 	 
ComputerShop/FormViews/FProductsGpuMain.cs 	 
ComputerShop/FormViews/FProductsHardDrivesMain.cs 	
ComputerShop/FormViews/FProductsMainboardsMain.cs 	 
ComputerShop/FormViews/FProductsPowerSupplyUnitsMain.cs
ComputerShop/FormViews/FProductsRAMMain.cs
ComputerShop/FormViews/FProductsScreensMain.cs

Wymienione wyżej pliki ograniczają się do zapytań Select, które są analogiczne do wyżej wymienionych. Zapytania te mają na celu pobranie wszystkich rekordów z konkretnej tabeli i wyświetlenie ich w DataGridView, a dokładnie takie parametry jak Marka, Cena, Rating. Oraz zapytania Select które mają za zadanie wyciągnąć informacje o aktuanych podzespołach dzięki INNER JOIN wykorzystująć products.SpecyficationsID, oraz ID konkretnego komponentu w tabeli specyfications. 	 

Zapytania:	
"SELECT DISTINCT ParametryPodzespołu FROM products INNER JOIN specyfications s on products.specyficationsID = s.ID INNER JOIN component on s.component = r.ID WHERE CPU IS NULL";

"SELECT DC_Output FROM table INNER JOIN specyfications s on component.ID = s.Component INNER JOIN products p on s.ID = p.specyficationsID WHERE Name = '"Parametr1 ]"' AND p.Price = "  Parametr2;


Parametry:	Parametry i Tabele
Komentarz:	To co jest również analogiczne w danych zapytaniach. To dodatkowe ograniczenie, gdzie jakieś komponent = null, Zrobiliśmy to dlatego że specyfikacja takiego komputera czy laptopa zawiera odniesienia do wszystkich podzespołów, których używa. Dlatego jeżeli bierzemy poszczególne komponenty takie jak np karta graficzna czy płyta główna to specyfications.CPU = null, Natomiast dla CPU wystarczy dać specyfications.Komponent inny niż płyta główna czy zasilanie (ponieważ laptopy ich nie posiadają) i wtedy dostaniemy tylko pojedyncze podzespoły CPU.


38.
Plik: 	ComputerShop/FormViews/FMain.cs 	 wiersz: 274
Zapytanie:	"SELECT City FROM addresses WHERE ID = @addressid"
Parametry:	@addressid
Komentarz:	Zapytanie to pobiera informacje o mieście użytkownika po numerze ID adresu z tabeli addresses. 



39.
Plik: 	ComputerShop/FormViews/FSettings.cs 	
Wiersze: 465, 478, 488, 498
Zapytania:
"SELECT * FROM user WHERE Name = '" + NameTextBox.Text.Trim() + "' AND Name NOT IN ('" + UserName + "')  AND Surname ='" + SurnameTextBox.Text.Trim() + "' AND Surname NOT IN ('" + Surname + "')";
"SELECT * FROM user WHERE Login = '" + LoginTextBox.Text.Trim() + "' AND Login NOT IN ('"+Login+"')"
"SELECT * FROM user WHERE Email = '" + EmailTextBox.Text.Trim() + "' AND Email NOT IN ('"+ Email+"')"
"SELECT * FROM user WHERE Phone_number = '" + PhoneNumberTextBox.Text.Trim() + "' AND Phone_number NOT IN ('"+PhoneNumber+"')"


Parametry:	
xxxxxxxxTextBox.Text.Trim() - wpisane przez użytkownika dane, na którymi chce zamienić obecnie zapisane w bazie 
Pozostałe - obecnie zapisane w bazie dane użytkownika 

Komentarz:	Zapytania te mają na celu sprawdzenie czy wprowadzone przez użytkownika dane mogą zastąpić te obecnie znajdujące się w bazie. Jeżeli dane podane przez użytkownika dane znajdują się już w bazie (np. adres email, login) wtedy nie dochodzi do zamiany.

40.
Plik: 	ComputerShop/FormViews/AuthenticationModel.cs 	
Wiersze: 45
Zapytania:
"SELECT * FROM user WHERE Login = '" + Login.Trim() + "' and Password = '" + Password.Trim() + "'"

Parametry:	
Login.Trim() - login wprowadzony przez użytkownika
Password.Trim() - hasło wprowadzone przez użytkownika  

Komentarz:	Zapytanie to ma na celu pobranie danych użytkownika, dla którego przypisana jest wprowadzona kombinacja loginu i hasła







41.
Plik: 	ComputerShop/FormViews/AuthenticationModel.cs 	
Wiersze: 62
Zapytania:
"SELECT ID FROM user WHERE Login='" + Login.Trim() + "' AND Password = '" + Password.Trim() + "'"

Parametry:	
Login.Trim() - login wprowadzony przez użytkownika
Password.Trim() - hasło wprowadzone przez użytkownika  

Komentarz:	Zapytanie to ma na celu pobranie ID użytkownika, dla którego przypisana jest wprowadzona kombinacja loginu i hasła 

42.
Plik: 	ComputerShop/FormViews/AuthenticationModel.cs 	
Wiersze: 76
Zapytania:
"SELECT ID FROM addresses WHERE Street='" + Street.Trim() + "' AND Number ='" + HouseNumber.Trim() + "' AND City='" + City.Trim() + "' AND Post_code='" + PostCode.Trim() + "'";

Parametry:	
Street.Trim() - ulica wprowadzona przez użytkownika
HouseNumber.Trim() - numer domu wprowadzony przez użytkownika  
City.Trim() - miasto wprowadzone przez użytkownika
PostCode.Trim() - kod pocztowy wprowadzony przez użytkownika   

Komentarz:	Zapytanie to ma na celu pobranie ID adresu, dla kombinacji wprowadzonych przez użytkownika danych
















43.
Plik: 	ComputerShop/FormViews/ErrorLabelModel.cs 	
Wiersze: 290, 302, 312, 322
Zapytania:
"SELECT * FROM user WHERE Name = '" + item.UserName.Trim() + "' and Surname = '" + item.Surname.Trim() + "'"
"SELECT * FROM user WHERE Login = '" + item.Login.Trim() + "'"
"SELECT * FROM user WHERE Email = '" + item.Email.Trim() + "'"
 "SELECT * FROM user WHERE Phone_number = '" + item.PhoneNumber.Trim() + "'"

Parametry:	
item.UserName.Trim() - imię użytkownika pobrana z okna rejestracji
item.Surname.Trim() - nazwisko użytkownika pobrane z okna rejestracji
item.Login.Trim() - login użytkownika pobrany z okna rejestracji 
item.Email.Trim() - email użytkownika pobrany z okna rejestracji
item.PhoneNumber.Trim() - numer telefonu użytkownika pobrany z okna rejestracji 

Komentarz:	Powyższe zapytania mają na celu pobranie informacji z bazy danych, za pomocą których następnie można stwierdzić czy dane przekazane w oknie rejestracji, nie istnieją już w bazie.

44.
Plik: 	ComputerShop/FormViews/ErrorLabelModel.cs 	
Wiersze: 345, 358, 368, 378
Zapytania:
"SELECT * FROM user WHERE (Name NOT IN ('" + item.UserName.Trim() + "') AND Surname NOT IN ( '" + item.Surname.Trim() + "'))"
 "SELECT * FROM user WHERE Login = '" + item.Login.Trim() + "'"
 "SELECT * FROM user WHERE Email = '" + item.Email.Trim() + "'"
"SELECT * FROM user WHERE Phone_number = '" + item.PhoneNumber.Trim() + "'

Parametry:	
item.UserName.Trim() - imię użytkownika pobrana z okna ustawień
item.Surname.Trim() - nazwisko użytkownika pobrane z okna ustawień
item.Login.Trim() - login użytkownika pobrany z okna ustawień
item.Email.Trim() - email użytkownika pobrany z okna ustawień 
item.PhoneNumber.Trim() - numer telefonu użytkownika pobrany z okna ustawień 

Komentarz:	Powyższe zapytania mają na celu pobranie informacji z bazy danych, za pomocą których następnie można stwierdzić czy dane przekazane w oknie ustawień, nie istnieją już w bazie.


Update

1.
Plik: 	ComputerShop/FormViews/FSettings.cs 	
Wiersze: 549, 557, 565, 573, 581, 589, 597, 605, 613, 621
Zapytania:	
"UPDATE user SET Name = '"+NameTextBox.Text.Trim()+ "' WHERE ID = @userid "
"UPDATE user SET Surname = '" + SurnameTextBox.Text.Trim() + "' WHERE ID = @userid "
"UPDATE user SET Login = '" + LoginTextBox.Text.Trim() + "' WHERE ID = @userid "
 "UPDATE user SET Password = '" + PasswordTextBox.Text.Trim() + "' WHERE ID = @userid "
"UPDATE user SET Email = '" + EmailTextBox.Text.Trim() + "' WHERE ID = @userid "
"UPDATE user SET Phone_number = '" + PhoneNumberTextBox.Text.Trim() + "' WHERE ID = @userid "
"UPDATE addresses SET Street = '" + StreetTextBox.Text.Trim() + "' WHERE ID = @addressid "
"UPDATE addresses SET Number = '" + NumberTextBox.Text.Trim() + "' WHERE ID = @addressid "
"UPDATE addresses SET City = '" + CityTextBox.Text.Trim() + "' WHERE ID = @addressid "
"UPDATE addresses SET Post_code = '" + PostCodeTextBox.Text.Trim() + "' WHERE ID = @addressid "


Parametry:	
xxxxxxxxTextBox.Text.Trim() - wpisane przez użytkownika dane, na którymi chce zamienić obecnie zapisane w bazie 
Komentarz:	Powyższe zapytania mają na celu zastąpienie obecnie zapisanych w bazie danych nowymi danymi wprowadzonymi przez użytkownika












Delete

1.
Plik: 	ComputerShop/FormViews/FSettings.cs 	
Wiersze: 644
Zapytania:	
"Delete From orders where UserID = " + UserId;

Parametry:	
UserID - ID obecnie zalogowanego użytkownika 
Komentarz:	Powyższe zapytania mają na usunięcie zamówień dokonanych przez użytkownika, który zdecydował się usunąć swoje konto 

2.
Plik: 	ComputerShop/FormViews/FSettings.cs 	
Wiersze: 652
Zapytania:	
"Delete From user where ID = " + UserId

Parametry:	
UserID - ID obecnie zalogowanego użytkownika 
Komentarz:	Powyższe zapytania mają na usunięcie obecnie zalogowanego użytkownika 

