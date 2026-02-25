document.addEventListener('DOMContentLoaded', () => {

    // Smooth scrolling for anchor links
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            e.preventDefault();
            const targetId = this.getAttribute('href');
            if (targetId === '#') return;

            const targetElement = document.querySelector(targetId);
            if (targetElement) {
                const headerOffset = 80;
                const elementPosition = targetElement.getBoundingClientRect().top;
                const offsetPosition = elementPosition + window.pageYOffset - headerOffset;

                window.scrollTo({
                    top: offsetPosition,
                    behavior: 'smooth'
                });
            }
        });
    });

    // Countdown Timer Logic
    const countdownDateEl = document.getElementById('countdown-date');
    const countdownTimeEl = document.getElementById('countdown-time');

    // Use the desired date (today's date) to create scarcity
    const now = new Date();
    const todayStr = `${now.getDate().toString().padStart(2, '0')}/${(now.getMonth() + 1).toString().padStart(2, '0')}/${now.getFullYear()}`;
    if (countdownDateEl) {
        countdownDateEl.textContent = todayStr;
    }

    // Mobile Menu Logic
    const mobileMenuBtn = document.getElementById('mobile-menu-btn');
    const mobileMenuOverlay = document.getElementById('mobile-menu');
    const mobileLinks = document.querySelectorAll('.mobile-link');

    if (mobileMenuBtn && mobileMenuOverlay) {
        mobileMenuBtn.addEventListener('click', () => {
            const isOpen = mobileMenuOverlay.classList.contains('open');
            if (isOpen) {
                mobileMenuOverlay.classList.remove('open');
                mobileMenuBtn.innerHTML = '☰';
            } else {
                mobileMenuOverlay.classList.add('open');
                mobileMenuBtn.innerHTML = '&times;';
            }
        });

        mobileLinks.forEach(link => {
            link.addEventListener('click', () => {
                mobileMenuOverlay.classList.remove('open');
                mobileMenuBtn.innerHTML = '☰';
            });
        });
    }

    // FAQ Accordion Logic
    const faqItems = document.querySelectorAll('.faq-item');
    faqItems.forEach(item => {
        const questionBtn = item.querySelector('.faq-question');
        const answer = item.querySelector('.faq-answer');

        questionBtn.addEventListener('click', () => {
            const isActive = item.classList.contains('active');

            // Close all
            faqItems.forEach(acc => {
                acc.classList.remove('active');
                acc.querySelector('.faq-answer').style.maxHeight = null;
            });

            // If it wasn't active, open it
            if (!isActive) {
                item.classList.add('active');
                answer.style.maxHeight = answer.scrollHeight + 'px';
            }
        });
    });

    // Fake Sales Notification Popup Logic
    const salesPopup = document.getElementById('sales-popup');
    const buyerNameEl = document.getElementById('buyer-name');

    // Brazilian common names to simulate purchases
    const names = [
        'João V.', 'Maria S.', 'Pedro H.', 'Lucas A.', 'Ana P.',
        'Carlos M.', 'Fernanda G.', 'Rafael C.', 'Juliana T.', 'Marcos L.',
        'Gabriel R.', 'Beatriz F.', 'Matheus D.', 'Camila O.', 'Thiago B.'
    ];

    const showNotification = () => {
        // Pick a random name
        const randomName = names[Math.floor(Math.random() * names.length)];
        buyerNameEl.textContent = randomName;

        // Show popup
        salesPopup.classList.add('show');

        // Hide after 5 seconds
        setTimeout(() => {
            salesPopup.classList.remove('show');
        }, 5000);
    };

    // Show first notification after 10 seconds
    setTimeout(() => {
        showNotification();
        // Then randomly show every 15-30 seconds
        setInterval(() => {
            showNotification();
        }, Math.floor(Math.random() * (30000 - 15000 + 1) + 15000));
    }, 10000);
});
