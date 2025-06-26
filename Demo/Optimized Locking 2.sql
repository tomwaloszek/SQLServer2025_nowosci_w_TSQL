SELECT * FROM dbo.BJJAthleteWins
WHERE Wins < 75 

BEGIN TRAN
-- UPDATE tez powinien przej�� bez blokady (je�li LAQ dzia�a),
-- bo zaden z tych wierszy nie by� zablokowany wcze�niej przez pierwsza transakcje.

UPDATE dbo.BJJAthleteWins
SET Wins = Wins + 1
WHERE Wins < 75;

COMMIT TRAN


BEGIN TRAN
-- UPDATE nie powinien przejsc z racji blokady na >75 w g�re.

UPDATE dbo.BJJAthleteWins
SET Wins = Wins + 1
WHERE Wins > 75;


COMMIT TRAN