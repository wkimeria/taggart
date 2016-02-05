Bundler.require :web
Bundler.require :development if development?
require 'open-uri'
#require_relative 'tag_counter'
require_relative 'taggart/helpers/tag_counter'
require 'cgi'

set :public_folder, 'public'


# Show page where user can input the url to fetch page from
get '/' do
  haml :index

end

#validate the url, fetch the page and return page and count of tags
post '/' do
  url = get_url(params)

  # Handle Redirection (should we allow or warn the user?)
  page = get_page(url)
  puts page
  tags = get_tags(page)
  #page = CGI::escapeElement(page, "script")
  page = CGI::escapeHTML(page)
  haml(:tags, :locals => {:url => url, :tags => tags, :source => page})
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

#TODO: Get the url and validate that it is indeed a correct url
def get_url(params)
  #TODO: Validate URL
  url = params.fetch('url')
  url
end

#TODO
def get_page(url)
  page = Nokogiri::HTML(open(url))
  page = page.to_s.encode!('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: '')
  page
end


#TODO write algorithm to find tags and their positions
def get_tags(page)
  tags = Taggart::Helpers::TagCounter.new().parse(page)
  tags
=begin
  tags = {"html" => {"count" => 1, "positions" => [[1, 6], [110, 113]]},
          "body" => {"count" => 1, "positions" => [[7, 10], [100, 112]]},
          "hr" => {"count" => 1, "positions" => [[7, 10]]},
          "table" => {"count" => 3, "positions" => [[7, 10], [100, 112]]}
  }
  tags
=end
end
