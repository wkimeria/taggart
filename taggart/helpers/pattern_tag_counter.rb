# A class to count html tags in a html document provided. A tag is defined as any text following
# a certain regex pattern (<ELEMENT>)
require_relative '../../taggart/helpers/tag_counter'

module Taggart
  module Helpers
    class PatternTagCounter < TagCounter

      def initialize()

      end

      # For each valid html tag, get its count in the given document.
      # If a tag does not exist in the document it is not included
      #in the count
      #
      # * *Args*
      # * +document+ - html source to search for tags
      #
      # * *Returns* :
      #   - A hashmap where the key is the tag and the value is the count in the document
      def get_tag_counts(document)
        super(document, get_unique_tags(document))
      end

      # Get a unique list of html tags in the document provided
      #
      # * *Args*
      # * +document+ - html source to search for tags
      #
      # * *Returns* :
      #   - A list of unique html tags
      def get_unique_tags(document)
        unique_tags = []
        tag_data = document.scan(/<(\w+)[^>]*>/i)
        tag_data.each do |i|
          unique_tags << i[0] unless unique_tags.include?(i)
        end
        unique_tags
      end

    end
  end
end
