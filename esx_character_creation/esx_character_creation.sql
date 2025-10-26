-- Dodaj nową kolumnę do tabeli `users`, aby przechowywać wybór postaci.
-- Domyślna wartość `NULL` oznacza, że gracz jeszcze nie dokonał wyboru.
ALTER TABLE `users` ADD COLUMN `character_choice` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci';
