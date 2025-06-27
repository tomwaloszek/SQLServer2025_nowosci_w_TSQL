-- Optimized Locking

-- Utwórz tabelę wyników zawodników BJJ
DROP TABLE IF EXISTS dbo.BJJAthleteWins;
CREATE TABLE dbo.BJJAthleteWins
(
    AthleteID INT PRIMARY KEY,
    AthleteName NVARCHAR(100),
    Wins INT
);





INSERT INTO dbo.BJJAthleteWins (AthleteID, AthleteName, Wins)
VALUES 
(1, 'Gordon Ryan', 75),
(2, 'Marcus Almeida "Buchecha"', 138),
(3, 'Andre Galvao', 110),
(4, 'Mackenzie Dern', 68),
(5, 'Roger Gracie', 90),
(6, 'Rafael Lovato Jr.', 85),
(7, 'Kade Ruotolo', 35),
(8, 'Tainan Dalpra', 40),
(9, 'Mikey Musumeci', 55),
(10, 'Ffion Davies', 50);
GO




-- Wyświetl dane zawodników
SELECT * FROM dbo.BJJAthleteWins;




-- Rozpocznij transakcję: aktualizacja liczby wygranych walk wszystkich zawodników
BEGIN TRANSACTION;

UPDATE BJJAthleteWins
SET Wins = Wins + 1;  -- każdy zawodnik wygrywa 1 dodatkową walkę

SELECT
    resource_type,
    resource_description,
    request_mode,
    request_status,
    request_session_id
FROM sys.dm_tran_locks
WHERE request_session_id = @@SPID
      AND resource_type IN ('PAGE', 'RID', 'KEY', 'XACT');

COMMIT TRANSACTION;


-- Sesja 1

BEGIN TRANSACTION;

UPDATE BJJAthleteWins
SET Wins = Wins + 1
WHERE Wins >= 75 

SELECT
    resource_type,
    resource_description,
    request_mode,
    request_status,
    request_session_id
FROM sys.dm_tran_locks
WHERE request_session_id = @@SPID
      AND resource_type IN ('PAGE', 'RID', 'KEY', 'XACT');

COMMIT TRANSACTION;
