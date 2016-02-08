Bundler.require :web
Bundler.require :development if development?
require 'open-uri'
require_relative 'taggart/helpers/tag_counter'
require_relative 'taggart/helpers/html_page'
require 'cgi'
require 'uri'
require 'logger'
require 'net/http'

configure :production do
  set :haml, {:ugly => true}
  set :clean_trace, true

  Dir.mkdir('logs') unless File.exist?('logs')

  $logger = Logger.new('logs/common.log', 'weekly')
  $logger.level = Logger::WARN

  # Spit stdout and stderr to a file during production
  # in case something goes wrong
  $stdout.reopen("logs/output.log", "w")
  $stdout.sync = true
  $stderr.reopen($stdout)
end

configure :development do
  $logger = Logger.new(STDOUT)
end

set :public_folder, 'public'


# Show page where user can input the url to fetch page from
get '/' do
  haml :index

end

#validate the url, fetch the page and return page and count of tags
post '/' do

  html_doc = nil

  begin
    url = get_url(params)
    html_doc = Taggart::Helpers::HtmlPage.new(url)

    if html_doc.status != 200
      raise StandardError, "Unable to fetch requested page. Status returned was #{html_doc.status}"
    end

    unescaped_page = html_doc.source
    tags = get_tags(unescaped_page)
    page = CGI::escapeHTML(unescaped_page)

  rescue => e
    logger.info(e.message)
    halt(400, haml(:index, :locals => {:url => url, :error_message => e.message}))
  end

  if html_doc.redirect_url.nil?
    haml(:index, :locals => {:url => url, :tags => tags, :source => page})
  else
    logger.info("redirected to #{html_doc.redirect_url} when #{url} was requested.")
    # Display information to user that redirection occured
    haml(:index, :locals => {:url => html_doc.redirect_url, :tags => tags, :source => page, :redirect_url => html_doc.redirect_url})
  end
end


get '/style.css' do
  scss :style
end


not_found do
  haml :'404'
end

# Get url from params and validate it
def get_url(params)
  url = params.fetch('url')
  if (url =~ URI::regexp).nil?
    raise ArgumentError, "Invalid Url provided"
  end
  url
end

# Get Tag Counts in html page
def get_tags(page)
  Taggart::Helpers::TagCounter.new().get_tag_counts(page)
end
