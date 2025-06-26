/*
Funkcja CURRENT_DATE zwraca dzisiejszą datę (DATE) — bez części czasowej.
To uproszczony zapis dostępny  w Azure SQL Database.
*/


SELECT CURRENT_DATE





/*
Funkcje BASE64_ENCODE i BASE64_DECODE umożliwiają konwersję danych binarnych do/z formatu Base64 
*/


SELECT Base64_Encode(0xA9) AS "Encoded © symbol";



--BASE64_ENCODE default vs url_safe

SELECT BASE64_ENCODE(0xCAFECAFE);

SELECT BASE64_ENCODE(0xCAFECAFE, 1);


-------------------------------------------
SELECT BASE64_DECODE('qQ==');

SELECT BASE64_DECODE('yv7K/g==');

SELECT BASE64_DECODE('yv7K_g');

-------------------------------------------
