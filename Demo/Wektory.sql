/* #############################################
   ##   FIZYKA EKSPERYMENTALNA – DANE + VECTOR ##


    Cel eksperymentu:
    Zmierzyć parametry ruchu różnych obiektów (mas, prędkości, energii) w wybranych warunkach fizycznych, 
    takich jak:
        swobodny spadek (Free Fall),
        ruch paraboliczny (Projectile Motion),
        zderzenia (Collision Test),
        oddziaływania magnetyczne (Magnetic Deflection).

   ############################################# */

DROP TABLE IF EXISTS dbo.PhysicsMeasurements;
GO
CREATE TABLE dbo.PhysicsMeasurements
(
    measurement_id INT PRIMARY KEY,
    experiment NVARCHAR(100),
    scientist NVARCHAR(100),
    energy FLOAT,                   -- Energia w dżulach
    vector_data VECTOR(3)          -- Wektor 3D, np. [vx, vy, vz] jako prędkość w m/s
);
GO


INSERT INTO dbo.PhysicsMeasurements (measurement_id, experiment, scientist, energy, vector_data) VALUES
(1, 'Free Fall', 'Dr. Alice Newton', 240.1, '[0.0, -9.8, 0.0]'),
(2, 'Projectile Motion', 'Prof. Brian Hertz', 305.4, '[12.3, 15.6, 0.0]'),
(3, 'Collision Test', 'Dr. Lisa Curie', 134.7, '[-6.1, 0.0, 3.2]'),
(4, 'Magnetic Deflection', 'Dr. Max Planck', 198.2, '[0.0, 5.0, 7.8]');
GO


SELECT * FROM dbo.PhysicsMeasurements;
GO




SELECT AVG(energy) AS AvgEnergy_J
FROM dbo.PhysicsMeasurements;
GO

-- Przykład błędny – spowoduje błąd wykonania
DECLARE @invalid VECTOR(10) = '[0.1, 2, 30]';
SELECT @invalid;
GO


--Obliczenie znormalizowanych wektorów dla różnych norm
SELECT 
    measurement_id,
    experiment,
    vector_data AS OriginalVector,

    VECTOR_NORM(vector_data, 'norm2') AS EuclideanNorm,   -- L2
    VECTOR_NORM(vector_data, 'norm1') AS ManhattanNorm,   -- L1
    VECTOR_NORM(vector_data, 'norminf') AS MaxNorm        -- L∞
FROM dbo.PhysicsMeasurements;
GO



--Obliczenie znormalizowanych (jednostkowych) wektorów
SELECT 
    measurement_id,
    experiment,
    vector_data AS OriginalVector,

    VECTOR_NORMALIZE(vector_data, 'norm2') AS Normalized_Euclidean,
    VECTOR_NORMALIZE(vector_data, 'norm1') AS Normalized_Manhattan,
    VECTOR_NORMALIZE(vector_data, 'norminf') AS Normalized_Max
FROM dbo.PhysicsMeasurements;
GO




-- Obliczenie odległości między każdym pomiarem a eksperymentem "Free Fall"
SELECT 
    p1.experiment AS ReferenceExperiment,
    p2.experiment AS ComparedExperiment,
    p1.vector_data AS Vector1,
    p2.vector_data AS Vector2,

    VECTOR_DISTANCE('EUCLIDEAN', p1.vector_data, p2.vector_data) AS Distance_Euclidean,
    VECTOR_DISTANCE('COSINE', p1.vector_data, p2.vector_data) AS Distance_Cosine
FROM dbo.PhysicsMeasurements p1
CROSS JOIN dbo.PhysicsMeasurements p2
WHERE p1.experiment = 'Free Fall';  -- punkt odniesienia
GO

