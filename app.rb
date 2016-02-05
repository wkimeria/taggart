Bundler.require :web
Bundler.require :development if development?
require 'open-uri'

# Show page where user can input the url to fetch page from
get '/' do
  haml :index

end

#validate the url, fetch the page and return page and count of tags
post '/' do
  url = get_url(params)

  # Handle Redirection (should we allow or warn the user?)
  page = get_page(url)
  tags = get_tags(page)
  haml(:tags, :locals => {:url => url, :tags => tags, :source => page.to_s.encode!('UTF-8', 'UTF-8', :invalid => :replace)})
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
  page
end


#TODO write algorithm to find tags and their positions
def get_tags(page)
  tags = {"html" => {"count" => 1, "positions" => [[1,6],[110,113]]},
          "body" => {"count" => 1, "positions" => [[7,10],[100,112]]},
          "hr" => {"count" => 1, "positions" => [[7,10]]},
          "table" => {"count" => 3, "positions" => [[7,10],[100,112]]}
  }
  tags
end
