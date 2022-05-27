# Activate and configure extensions
# https://middlemanapp.com/advanced/configuration/#configuring-extensions

activate :aria_current
activate :inline_svg
# https://middlemanapp.com/advanced/pretty-urls/
activate :directory_indexes
activate :autoprefixer do |config|
  config.browsers = 'last 2 versions'
end

# Set time zone
set :time_zone, 'America/Detroit'

# Import custom libraries and helpers
Dir['./*/*.rb'].each { |file| load file }
include FaviconsHelper

# Load Sass from node_modules
# config[:sass_assets_paths] << File.join(root, 'node_modules')

set :css_dir, "assets/stylesheets"
set :fonts_dir, "assets/fonts"
set :images_dir, "assets/images"
set :js_dir, "assets/javascripts"
set :markdown,
  autolink: true,
  fenced_code_blocks: true,
  footnotes: true,
  highlight: true,
  smartypants: true,
  strikethrough: true,
  tables: true,
  with_toc_data: true
set :markdown_engine, :redcarpet

# Set favicons
set :favicons, [
  {
    rel: 'apple-touch-icon',
    size: '180x180',
    icon: 'apple-touch-icon.png'
  },
  {
    rel: 'icon',
    type: 'image/png',
    size: '32x32',
    icon: 'favicon32x32.png'
  },
  {
    rel: 'icon',
    type: 'image/png',
    size: '16x16',
    icon: 'favicon16x16.png'
  },
  {
    rel: 'shortcut icon',
    size: '64x64,32x32,24x24,16x16',
    icon: 'favicon.ico'
  }
]

# ignore "*.scss"

activate :external_pipeline,
         name: :sass,
         command: build? ? "bin/sass" : "bin/sass development",
         source: "tmp",
         latency: 1

# activate :external_pipeline,
#          name: :webpack,
#          command: build? ? './node_modules/webpack/bin/webpack.js --bail' : './node_modules/webpack/bin/webpack.js --watch -d',
#          source: ".tmp/dist",
#          latency: 1

# activate :external_pipeline,
#          name: :webpack,
#          command: build? ? 'yarn run build' : 'yarn run start',
#          source: 'dist',
#          latency: 1

activate :dotenv
# activate :meta_tags

# Layouts
# https://middlemanapp.com/basics/layouts
page '/*.xml',  layout: false
page '/*.json', layout: false
page '/*.txt',  layout: false

# With alternative layout
# page '/path/to/file.html', layout: 'other_layout'

# Proxy pages
# https://middlemanapp.com/advanced/dynamic-pages

# proxy(
#   '/this-page-has-no-template.html',
#   '/template-file.html',
#   locals: {
#     which_fake_page: 'Rendering a fake page with a local variable'
#   }
# )
[
  "404", "about", "changelog", "login", "pricing", "privacy", "signup", "styleguide", "testimonials", "usecases"
].each do |name|
  page "/#{name}.html"
end

###
# Helpers
###

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Methods defined in the helpers block are available in templates
# https://middlemanapp.com/basics/helper-methods

# helpers do
#   def some_helper
#     'Helping'
#   end
# end

# Use sprockets for JS requires
# activate :sprockets

###
## Blog settings
###
# activate :blog do |blog|
#   blog.prefix = '/blog'
#   blog.sources = '{year}-{month}-{day}-{title}.html'
#   blog.permalink = '{year}/{month}/{day}/{title}.html'
#   blog.taglink = 'tags/{tag}.html'
#   blog.layout = 'article'
#   blog.summary_separator = /(READMORE)/
#   blog.summary_length = 250
#   blog.year_link = '{year}.html'
#   blog.month_link = '{year}/{month}.html'
#   blog.day_link = '{year}/{month}/{day}.html'
#   blog.default_extension = 'md'

#   blog.tag_template = '/blog/tag.html'
#   blog.calendar_template = '/blog/calendar.html'

#   blog.paginate = true
#   blog.per_page = 5
#   blog.page_link = 'p{num}'
# end

# Setup blog feed
# page '/blog/feed.xml'

# Build-specific configuration
# https://middlemanapp.com/advanced/configuration/#environment-specific-settings

configure :production do
  activate :asset_hash
  activate :gzip
  activate :minify_css
  activate :minify_html
  activate :minify_javascript
end

configure :development do
  set      :debug_assets, true
  activate :livereload
  # activate :pry
end

configure :build do
  # ignore   File.join(config[:js_dir], '*') # handled by webpack
  set      :asset_host, @app.data.site.host
  set      :relative_links, true
  activate :asset_hash
  activate :favicon_maker, icons: generate_favicons_hash
  activate :gzip
  activate :minify_css
  activate :minify_html
  activate :minify_javascript
  activate :relative_assets
  activate :robots, rules: [{ user_agent: '*', allow: %w[/] }],
                    sitemap: File.join(@app.data.site.host, 'sitemap.xml')
end