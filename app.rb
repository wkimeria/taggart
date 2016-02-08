Bundler.require :web
Bundler.require :development if development?
require 'open-uri'
#require_relative 'tag_counter'
require_relative 'taggart/helpers/tag_counter'
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


#set :raise_errors, false
#set :show_exceptions, false

# Show page where user can input the url to fetch page from
get '/' do
  haml :index

end

#validate the url, fetch the page and return page and count of tags
post '/' do
  begin
    url = get_url(params)
    page_info = get_page(url)
    page = page_info[0]
    redirect_location = page_info[1]
    tags = get_tags(page)
    page = CGI::escapeHTML(page)
  rescue => e
    logger.info(e.message)
    halt(400, haml(:index, :locals => {:url => url, :error_message => e.message}))
  end

  if redirect_location.nil?
    haml(:index, :locals => {:url => url, :tags => tags, :source => page})
  else
    haml(:index, :locals => {:url => redirect_location, :tags => tags, :source => page, :redirect_url => redirect_location})
  end
end


get '/style.css' do
  scss :style
end

get '/' do
  haml :index
end

not_found do
  haml :'404'
end

def get_url(params)
  url = params.fetch('url')
  if (url =~ URI::regexp).nil?
    raise ArgumentError, "Invalid Url provided"
  end
  url
end

#TODO
def get_page(url)
  page = nil
  page_response = []
  begin

    page_response = fetch(url)

    if page_response[0] != 200 || page_response[1].nil?
      raise ArgumentError, "Unable to fetch requested page"
    end

    page = Nokogiri::HTML(page_response[1].body.to_s)
    page = page.to_s.encode!('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: '')

  rescue
    raise StandardError, "Unable to fetch requested page"
  end

  [page, page_response[2]]
end

# Fetch the page at the given url. Return 200 for success, along with the response
# If a redirect occured, the redirected to url will be present in the third argument
# returned (which would otherwise be nil)
def fetch(uri_str, limit = 10, new_uri=nil)

  raise ArgumentError, 'too many HTTP redirects' if limit == 0

  response = Net::HTTP.get_response(URI(uri_str))

  case response
    when Net::HTTPSuccess then
      [200, response, new_uri]
    when Net::HTTPRedirection then
      location = response['location']
      warn "redirected to #{location}"
      fetch(location, limit - 1, location)
    else
      [404, response, uri_str]
  end
end

# Get Tag Counts in html page
def get_tags(page)
  Taggart::Helpers::TagCounter.new().get_tag_counts(page)
end
