/* #############################################
   ##   REGEX & FUZZY MATCHING SQL SKRYPT    ##
   ############################################# */

SELECT name AS DatabaseName, 
       compatibility_level 
FROM sys.databases
WHERE name = 'DemoDB'; 

GO 
USE DemoDB
GO 

ALTER DATABASE CURRENT 
SET COMPATIBILITY_LEVEL = 170;





DROP TABLE IF EXISTS dbo.MarvelComics;
CREATE TABLE dbo.MarvelComics (
    ComicID INT PRIMARY KEY,
    Title NVARCHAR(150),
    Hero NVARCHAR(100),
    Genre NVARCHAR(50),
    Description NVARCHAR(500),
    ReleaseYear INT,
    Publisher NVARCHAR(100),
    Series NVARCHAR(100),
    Rating DECIMAL(3,1),
    FanReview NVARCHAR(500)
);




INSERT INTO dbo.MarvelComics (ComicID, Title, Hero, Genre, Description, ReleaseYear, Publisher, Series, Rating, FanReview) VALUES
(1, N'Spider-Man: Kraven’s Last Hunt', N'Spider-Man', N'Akcja', N'Mroczna historia o polowaniu Kravena na Człowieka-Pająka.', 1987, N'Marvel Comics', N'Spider-Man', 9.2, N'Jeden z najlepszych story arców w historii Marvela!'),
(2, N'X-Men: Days of Future Past', N'Wolverine', N'Sci-Fi', N'Podróże w czasie i walka o przyszłość mutantów.', 1981, N'Marvel Comics', N'X-Men', 9.0, N'Kultowa saga z mocnym przekazem społecznym.'),
(3, N'Daredevil: Born Again', N'Daredevil', N'Drama', N'Matt Murdock upada na samo dno... i powstaje.', 1986, N'Marvel Comics', N'Daredevil', 9.3, N'Frank Miller w najlepszym wydaniu.'),
(4, N'Infinity Gauntlet', N'Thanos', N'Kosmiczne', N'Thanos zdobywa Rękawicę Nieskończoności i staje się bogiem.', 1991, N'Marvel Comics', N'Infinity Saga', 8.8, N'Mega epicki crossover, must-read!'),
(5, N'Civil War', N'Iron Man', N'Polityczny Thriller', N'Bohaterowie dzielą się po uchwaleniu ustawy o rejestracji.', 2006, N'Marvel Comics', N'Marvel Events', 8.7, N'Zmusza do refleksji – czyje racje są słuszne?'),
(6, N'House of M', N'Scarlet Witch', N'Alternate Reality', N'Wanda tworzy nową rzeczywistość, gdzie mutanty rządzą światem.', 2005, N'Marvel Comics', N'X-Men Events', 8.5, N'Szokujący zwrot akcji i piękna kreska.'),
(7, N'Planet Hulk', N'Hulk', N'Sci-Fi', N'Hulk jako gladiator na obcej planecie.', 2006, N'Marvel Comics', N'Incredible Hulk', 8.9, N'Bardzo emocjonalna i brutalna historia.'),
(8, N'Old Man Logan', N'Wolverine', N'Postapo', N'Przyszłość bez bohaterów, Logan jako ostatni ocalały.', 2008, N'Marvel Comics', N'Wolverine', 9.1, N'Mistrzowski klimat, jak western superbohaterski.'),
(9, N'Secret Wars (2015)', N'Doctor Doom', N'Multiverse', N'Doom zostaje bogiem w zderzeniu światów.', 2015, N'Marvel Comics', N'Marvel Events', 8.6, N'Złożona fabuła i piękne rysunki.'),
(10, N'Captain America: Winter Soldier', N'Captain America', N'Szpiegowski', N'Steve Rogers mierzy się z przeszłością i przyjacielem-wojownikiem.', 2005, N'Marvel Comics', N'Captain America', 9.0, N'Doskonała historia o lojalności i zdradzie.');

GO




/* Wyszukiwanie komiksów z bohaterem Wolverine */
SELECT * FROM MarvelComics
WHERE REGEXP_LIKE(Hero, 'Wolverine', 'i');




/* Recenzje z entuzjastycznymi opiniami */
SELECT * FROM MarvelComics
WHERE REGEXP_LIKE(FanReview, 'epicki|must-read|mistrzowski', 'i');




/* Sprawdzenie poprawności formatu roku wydania */
SELECT * FROM MarvelComics
WHERE REGEXP_LIKE(CAST(ReleaseYear AS NVARCHAR(10)), '[0-9]{4}');



/* Pobranie recenzji zawierających słowo "historia" */
SELECT FanReview FROM MarvelComics
WHERE REGEXP_LIKE(FanReview, 'historia', 'i');



/* Przykład użycia REGEXP_REPLACE */
SELECT REGEXP_REPLACE(
'123-456-7890', 
'([0-9]{3})-([0-9]{3})-([0-9]{4})', 
'(\1) \2-\3');




/*
Fuzzy matching to technika dopasowywania ciągów znaków,
która pozwala znaleźć podobne, ale nie identyczne wartości. 
Wykorzystuje algorytmy takie jak Levenshtein (Edit Distance) czy Jaro-Winkler, 
aby porównywać teksty mimo literówek, błędów czy różnic w zapisie.

*/


/* #############################################
   ##     KOMIKSY MARVEL – FUZZY MATCHING     ##
   ############################################# */

/* Tworzenie tabeli z błędnie zapisanymi komiksami */
DROP TABLE IF EXISTS dbo.MarvelComicsFuzzy;
CREATE TABLE dbo.MarvelComicsFuzzy (
    ComicID INT PRIMARY KEY,
    Title NVARCHAR(150),
    Hero NVARCHAR(100),
    Genre NVARCHAR(50),
    Description NVARCHAR(500),
    ReleaseYear INT,
    Publisher NVARCHAR(100),
    Series NVARCHAR(100),
    Rating DECIMAL(3,1),
    FanReview NVARCHAR(500)
);

/* Wstawianie danych z błędami do MarvelComicsFuzzy */
INSERT INTO dbo.MarvelComicsFuzzy (ComicID, Title, Hero, Genre, Description, ReleaseYear, Publisher, Series, Rating, FanReview) VALUES
(1, N'Spider-Man: Kravens Last Hunt', N'Spiderman', N'Akcja', N'Kraven ściga Spidermana.', 1987, N'MarvelComic', N'Spiderman', 9.1, N'Swiete story!'),
(2, N'X Men: Days of Future Past', N'Wolverin', N'SciFi', N'Walczą z przyszłością mutantów.', 1981, N'Marvel Comics', N'XMen', 8.9, N'Kultowy komiks o czasach przyszłych.'),
(3, N'DareDevil: Born Agan', N'Dare Devil', N'Drama', N'Upadek Murdocka.', 1986, N'Marvell Comics', N'Dare Devil', 9.2, N'Kult!'),
(4, N'Infinity Gauntlt', N'Thanoss', N'Cosmic', N'Thanos zdobywa moc.', 1991, N'Marvel', N'InfinitySaga', 8.7, N'Epka!'),
(5, N'Sivil War', N'Ironman', N'Polityka', N'Bohaterowie w konflikcie.', 2006, N'Marvel Comics', N'MarvelEvnts', 8.6, N'Dobra jazda.'),
(6, N'House of M', N'ScarletWitch', N'AlterReality', N'Wanda zmienia świat.', 2005, N'MarvelComix', N'X-Men', 8.4, N'Crazy historia.'),
(7, N'Planet Hlk', N'Hulk', N'Scifi', N'Hulk jako gladiator.', 2006, N'Marvel Comics', N'Incredible Hlk', 8.8, N'Full emocje!'),
(8, N'OldMan Logan', N'Wolverene', N'Post-apok', N'Logan jako ostatni.', 2008, N'Marvl Comics', N'Wolverin', 9.0, N'Mega vibe.'),
(9, N'Secret Warz', N'Dr Doom', N'Multiversum', N'Doom rządzi.', 2015, N'Marvell', N'Marvel Eventz', 8.5, N'Mocna rzecz.'),
(10, N'Captain America: WinterSoldier', N'Capitan America', N'Szpiegowski', N'Steve kontra przeszłość.', 2005, N'Marvel', N'Captain Americca', 8.9, N'Klasyk!');

GO

/* Dopasowanie podobnych tytułów komiksów 
EDIT_DISTANCE - oblicza liczbę znaków, które należy zastąpić, wstawić lub usunąć, aby przekształcić jeden ciąg znaków w inny.

*/
SELECT a.Title AS OriginalTitle, 
       b.Title AS SimilarTitle, 
       EDIT_DISTANCE(a.Title, b.Title) AS EditDistance
FROM dbo.MarvelComicsFuzzy a
JOIN dbo.MarvelComicsFuzzy b ON a.ComicID <> b.ComicID
ORDER BY EditDistance;




/* Dopasowanie podobnych tytułów na podstawie EDIT_DISTANCE_SIMILARITY
zwraca wynik podobieństwa na podstawie odległości edycyjnej.

*/
SELECT a.Title AS OriginalTitle, 
       b.Title AS SimilarTitle, 
       EDIT_DISTANCE_SIMILARITY(a.Title, b.Title) AS Similarity
FROM dbo.MarvelComicsFuzzy a 
JOIN dbo.MarvelComicsFuzzy b ON a.ComicID <> b.ComicID
ORDER BY Similarity DESC;





/* Dopasowanie wydawnictw na podstawie 
JARO_WINKLER_DISTANCE
oblicza podobieństwo między dwoma ciągami znaków za pomocą algorytmu Jaro-Winklera.

*/



SELECT a.Publisher AS OriginalPublisher, 
       b.Publisher AS SimilarPublisher, 
       JARO_WINKLER_DISTANCE(a.Publisher, b.Publisher) AS Similarity
FROM dbo.MarvelComicsFuzzy a
JOIN dbo.MarvelComicsFuzzy b ON a.ComicID <> b.ComicID
ORDER BY Similarity DESC;



/* Dopasowanie podobnych nazw bohaterów 
JARO_WINKLER_SIMILARITY zwraca wynik podobieństwa przy użyciu algorytmu Jaro-Winklera

*/
SELECT a.Hero AS HeroA, b.Hero AS HeroB, 
       JARO_WINKLER_SIMILARITY(a.Hero, b.Hero) AS Similarity
FROM dbo.MarvelComicsFuzzy a
JOIN dbo.MarvelComicsFuzzy b ON a.ComicID <> b.ComicID
ORDER BY Similarity DESC;
