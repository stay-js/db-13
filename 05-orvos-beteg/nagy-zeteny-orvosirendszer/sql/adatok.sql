SET FOREIGN_KEY_CHECKS = 0;

-- Orvos adatok
INSERT INTO orvos (nev, szakterulet, elerheto) VALUES
('Dr. Kovács Lajos', 'sebészet', TRUE),
('Dr. Rudas Ádám', 'pszichológia', FALSE),
('Dr. Szabó Éva', 'fizikoterápia', TRUE),
('Dr. Nagy Anna', 'pszichológia', FALSE);

-- Páciens adatok
INSERT INTO paciens (nev, szuletesi_datum, taj_szam) VALUES
('Nagy Péter', '1985-06-12', '123456789'),
('Kiss Anna', '1992-11-03', '987654321'),
('Tóth Gábor', '1978-02-25', '456789123');

-- Kezelés adatok
INSERT INTO kezeles (orvos_id, paciens_id, datum, diagnozis, kezeles_tipus) VALUES
(1, 1, '2024-04-01', 'Térdsérülés', 'sebészet'),
(2, 2, '2024-04-03', 'Stressz', 'pszichológia'),
(3, 3, '2024-04-05', 'Hátfájás', 'fizikoterápia'),
(1, 2, '2024-04-10', 'Bokasérülés', 'sebészet'),
(1, 3, '2025-10-08', 'Lábtörés', 'sebészet'),
(2, 2, '2025-12-10', 'Stressz', 'pszichológia')
;
