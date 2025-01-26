const themeToggle = document.getElementById('theme-toggle');
const themeSpan = document.getElementById('theme-span');

function applyTheme(theme) {
    document.documentElement.classList.remove('theme-light', 'theme-dark');
    document.documentElement.classList.add(theme);
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
