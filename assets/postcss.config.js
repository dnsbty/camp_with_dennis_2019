const purgecss = require('@fullhuman/postcss-purgecss')({
  content: [
    '../lib/camp_with_dennis_2019_web/templates/**/*.html.eex'
  ],
  defaultExtractor: content => content.match(/[A-Za-z0-9-_:/]+/g) || []
})

module.exports = {
  plugins: [
    require('tailwindcss')('./tailwind.config.js'),
    require('autoprefixer'),
    ...process.env.NODE_ENV === 'production' ? [purgecss] : [],
  ],
}
