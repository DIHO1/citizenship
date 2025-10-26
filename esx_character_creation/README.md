# Skrypt powitalny z wyborem postaci dla ESX

Ten skrypt wyświetla nowym graczom ekran powitalny, na którym mogą zdefiniować pochodzenie swojej postaci. Wybór jest zapisywany w bazie danych i pojawia się tylko raz.

## Funkcje

-   **Nowoczesny interfejs użytkownika:** Estetyczny i responsywny design.
-   **Trzy opcje wyboru:** Obywatel USA, Legalny Imigrant, Nielegalny Imigrant.
-   **Pełna konfigurowalność:** Możliwość łatwej edycji tytułów i opisów w pliku `config.lua`.
-   **Jednorazowy wybór:** Ekran pojawia się tylko wtedy, gdy gracz nie dokonał jeszcze wyboru.
-   **Integracja z ESX:** Skrypt jest w pełni kompatybilny z `es_extended`.
-   **Opcjonalne nagrody:** Możliwość zdefiniowania nagród (pieniądze, przedmioty) za dokonany wybór.

## Instalacja

1.  **Pobierz skrypt:** Pobierz pliki skryptu i umieść folder `esx_character_creation` w swoim katalogu `resources`.
2.  **Zmodyfikuj bazę danych:**
    -   Otwórz plik `esx_character_creation.sql`.
    -   Skopiuj zawarte w nim zapytanie SQL i wykonaj je w swojej bazie danych (np. za pomocą phpMyAdmin).
    -   To zapytanie doda nową kolumnę `character_choice` do tabeli `users`.
3.  **Dodaj wpis w `server.cfg`:**
    -   Otwórz swój plik `server.cfg`.
    -   Dodaj następującą linię, upewniając się, że znajduje się ona **po** `es_extended`:
        ```cfg
        ensure esx_character_creation
        ```
4.  **Konfiguracja (opcjonalnie):**
    -   Otwórz plik `config.lua`.
    -   Możesz tam zmienić tytuły i opisy dla każdej z opcji, aby dopasować je do klimatu swojego serwera.

5.  **Uruchom ponownie serwer:** Zrestartuj swój serwer FiveM lub wpisz `refresh` i `start esx_character_creation` w konsoli serwera.

## Jak to działa?

Po wejściu na serwer, skrypt sprawdza w bazie danych, czy gracz dokonał już wyboru. Jeśli nie, wyświetla mu interfejs. Po kliknięciu jednej z opcji, wybór jest zapisywany w bazie danych, a interfejs jest zamykany na stałe dla tego gracza.
