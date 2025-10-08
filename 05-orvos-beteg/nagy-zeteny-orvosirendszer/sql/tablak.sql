CREATE TABLE orvos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nev VARCHAR(100) NOT NULL,
    szakterulet VARCHAR(100),
    elerheto BOOLEAN DEFAULT TRUE
);

CREATE TABLE paciens (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nev VARCHAR(100) NOT NULL,
    szuletesi_datum DATE,
    taj_szam VARCHAR(15) UNIQUE
);