SELECT * FROM dbo.BJJAthleteWins
WHERE Wins < 75 

BEGIN TRAN
-- UPDATE tez powinien przejœæ bez blokady (jeœli LAQ dzia³a),
-- bo zaden z tych wierszy nie by³ zablokowany wczeœniej przez pierwsza transakcje.

UPDATE dbo.BJJAthleteWins
SET Wins = Wins + 1
WHERE Wins < 75;

COMMIT TRAN


BEGIN TRAN
-- UPDATE nie powinien przejsc z racji blokady na >75 w góre.

UPDATE dbo.BJJAthleteWins
SET Wins = Wins + 1
WHERE Wins > 75;


COMMIT TRAN