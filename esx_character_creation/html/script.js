document.addEventListener('DOMContentLoaded', () => {
    const container = document.querySelector('.container');

    // Nasłuchiwanie na wiadomości z klienta Lua
    window.addEventListener('message', (event) => {
        const data = event.data;

        if (data.action === 'open') {
            updateContent(data.config);
            container.style.display = 'flex';
        }
    });

    // Obsługa kliknięcia przycisków wyboru
    document.querySelectorAll('.select-btn').forEach(button => {
        button.addEventListener('click', () => {
            const choice = button.getAttribute('data-choice');

            // Ukrycie interfejsu
            container.style.display = 'none';

            // Wysłanie wyboru do klienta Lua
            fetch(`https://${GetParentResourceName()}/choice`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json; charset=UTF-8',
                },
                body: JSON.stringify({
                    choice: choice,
                }),
            }).catch(err => console.error('Error sending choice to Lua:', err));
        });
    });

    // Funkcja do aktualizacji treści na podstawie konfiguracji
    function updateContent(config) {
        if (!config) return;

        // Obywatel
        const citizen = document.getElementById('citizen');
        if (citizen && config.citizen) {
            citizen.querySelector('.option-title').textContent = config.citizen.title;
            citizen.querySelector('.option-description').textContent = config.citizen.description;
        }

        // Legalny Imigrant
        const legalImmigrant = document.getElementById('legal_immigrant');
        if (legalImmigrant && config.legal_immigrant) {
            legalImmigrant.querySelector('.option-title').textContent = config.legal_immigrant.title;
            legalImmigrant.querySelector('.option-description').textContent = config.legal_immigrant.description;
        }

        // Nielegalny Imigrant
        const illegalImmigrant = document.getElementById('illegal_immigrant');
        if (illegalImmigrant && config.illegal_immigrant) {
            illegalImmigrant.querySelector('.option-title').textContent = config.illegal_immigrant.title;
            illegalImmigrant.querySelector('.option-description').textContent = config.illegal_immigrant.description;
        }
    }

    // Obsługa klawisza Escape do zamknięcia UI (opcjonalnie)
    document.addEventListener('keydown', (event) => {
        if (event.key === 'Escape') {
            container.style.display = 'none';
            fetch(`https://${GetParentResourceName()}/close`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json; charset=UTF-8' },
                body: JSON.stringify({}),
            }).catch(err => console.error('Error sending close signal to Lua:', err));
        }
    });
});
