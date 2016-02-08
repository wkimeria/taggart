# A class to represent a fetched html page, with attributes to indicate whether the original
# request to a given url was redirected, and the url that the redirection was to.

require 'uri'
require 'logger'
require 'net/http'

module Taggart
  module Helpers
    class HtmlPage

      attr_accessor :url, :source, :redirect_url, :status

      # Initialize the class with a given url. The page at the requested url
      # will be fetched
      #
      # * *Args*
      # * +url+ - The url of the page to fetch.
      def initialize(url)
        @url = url
        fetch(url)
      end


      # Fetch the page at the url given
      #
      # * *Args*
      # * +url+ - The url of the page to fetch.
      # * +limit+ - Number of redirects to allow, defaults to 10.
      # * +redirect_url+ - If this is set this indicates that this is a redirection to this url
      def fetch(url, limit = 10, redirect_url = nil)

        raise ArgumentError, 'too many HTTP redirects' if limit == 0

        begin
          response = Net::HTTP.get_response(URI(url))
        rescue
          #something went wrong, map it to 404
          @status = 404

          return
        end

        case response
          when Net::HTTPSuccess then
            @status = 200
            @redirect_url = redirect_url
            page = Nokogiri::HTML(response.body.to_s)
            @source = page.to_s.encode!('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: '')
          when Net::HTTPRedirection then
            location = response['location']
            fetch(location, limit - 1, location)
          else
            @status = 400
        end
      end
      private :fetch
    end
  end
end