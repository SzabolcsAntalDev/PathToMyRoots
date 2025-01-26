const lightThemeButton = document.getElementById('light-theme-button');
const darkThemeButton = document.getElementById('dark-theme-button');

function applyTheme(theme) {
    document.documentElement.classList.remove('theme-light', 'theme-dark');
    document.documentElement.classList.add(theme);
    localStorage.setItem('theme', theme);
}

lightThemeButton.addEventListener('click', () => {
    applyTheme('theme-light');
});

darkThemeButton.addEventListener('click', () => {
    applyTheme('theme-dark');
});
