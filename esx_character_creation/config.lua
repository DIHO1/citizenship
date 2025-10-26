Config = {}

-- W tym miejscu możesz dowolnie modyfikować tytuły i opisy,
-- które pojawią się w interfejsie użytkownika.
Config.Options = {
    ['citizen'] = {
        title = "Obywatel USA",
        description = "Urodzony i wychowany w Stanach Zjednoczonych. Posiadasz pełne prawa, dostęp do legalnej pracy i startujesz z niewielkim wsparciem finansowym. Twoja droga do sukcesu stoi otworem, ale pamiętaj, że prawo jest po to, by go przestrzegać."
    },
    ['legal_immigrant'] = {
        title = "Legalny Imigrant",
        description = "Przybyłeś do USA w poszukiwaniu lepszego życia, przechodząc przez wszystkie procedury prawne. Masz pozwolenie na pracę i dostęp do podstawowych usług. Twoja przyszłość zależy od Twojej ciężkiej pracy i determinacji w nowym kraju."
    },
    ['illegal_immigrant'] = {
        title = "Nielegalny Imigrant",
        description = "Przekroczyłeś granicę w cieniu, ryzykując wszystko dla marzenia o wolności. Nie masz żadnych dokumentów ani praw. Każdy dzień to walka o przetrwanie. Musisz być ostrożny, komu ufasz, i unikać stróżów prawa za wszelką cenę."
    }
}

-- Poniżej możesz zdefiniować akcje, które mają się wykonać po wyborze danej opcji.
-- Ta sekcja jest opcjonalna i wymaga odkomentowania kodu w server/main.lua
-- Config.Rewards = {
--     ['citizen'] = {
--         money = 500,
--         black_money = 0,
--         items = {
--             { name = 'bread', count = 5 },
--             { name = 'water', count = 5 }
--         }
--     },
--     ['legal_immigrant'] = {
--         money = 250,
--         black_money = 0,
--         items = {
--             { name = 'bread', count = 2 },
--             { name = 'water', count = 2 }
--         }
--     },
--     ['illegal_immigrant'] = {
--         money = 0,
--         black_money = 100,
--         items = {}
--     }
-- }
