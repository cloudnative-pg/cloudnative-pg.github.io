const defaultTheme = require('tailwindcss/defaultTheme')

// https://tailwindcss.com/docs/customizing-colors/#default-color-palette

module.exports = {
    plugins: [],
    theme: {
        extend: {}
    },
    content: [
        './layouts/**/*.{html,js}',
        './assets/**/*.{html,js}',
    ]
}