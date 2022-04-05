const { screens } = require('tailwindcss/defaultTheme')
const colors = require('tailwindcss/colors');
module.exports = {
    content: [
        "./layouts/**/*.html",
        "./content/**/*.md",
        "./content/**/*.html",
        "./assets/scripts/**/*.js"
    ],
    variants: {},
    plugins: [],
    // colors: colors,
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