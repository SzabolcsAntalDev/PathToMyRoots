const themeToggle = document.getElementById('theme-toggle');
const themeSpan = document.getElementById('theme-span');

function applyTheme(theme) {
    document.documentElement.classList.remove('theme-light', 'theme-dark');
    document.documentElement.classList.add(theme);

    themeToggle.checked = theme === 'theme-dark';
    themeSpan.textContent = theme === 'theme-dark' ? "Dark Theme" : "Light Theme";

    localStorage.setItem('theme', theme);
}

themeToggle.addEventListener('change', () => {
    if (themeToggle.checked) {
        themeSpan.textContent = "Dark Theme"
        applyTheme('theme-dark');
    }
    else {
        themeSpan.textContent = "Light Theme"
        applyTheme('theme-light');
    }
});

function initializeTheme() {
    const savedTheme = localStorage.getItem('theme') || 'theme-light';
    applyTheme(savedTheme);
}

initializeTheme();