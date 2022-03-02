const { screens } = require('tailwindcss/defaultTheme')

module.exports = {
    purge: [
        "./layouts/**/*.html",
        "./content/**/*.md",
        "./content/**/*.html",
        "./assets/scripts/**/*.js"
    ],
    darkMode: false, // or 'media' or 'class'
    variants: {},
    plugins: [],
    corePlugins: {
        textOpacity: false,
        float: false,
        clear: false,
        divideColor: false,
        divideOpacity: false,
        divideStyle: false,
        divideWidth: false,
        fontVariantNumeric: false,
        placeholderColor: false,
        placeholderOpacity: false,
        ringColor: false,
        ringOffsetColor: false,
        ringOffsetWidth: false,
        ringOpacity: false,
        ringWidth: false
    }
}