# A class to count valid html tags in a html document provided
module Taggart
  module Helpers
    class TagCounter

      # Initialize the class with a valid list of html tags
      #
      def initialize(valid_tags)
        valid_tags = valid_tags
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
      def get_tag_counts(document, valid_tags)
        tag_counts = {}
        valid_tags.each do |t|
          count = get_tag_count(document, t)
          tag_counts[t] = count if count != 0
        end
        tag_counts
      end

      # Get the count of start html tags
      # This will match tags of the following form
      # <body>
      # <body class="xx">
      # <body/>
      # it will not match closing tags, because a complete tag is defined as either an open
      # close tag or a
      # <body></body>
      # <body/>
      #
      # * *Args*
      # * +document+ - html source to search for tags
      # * +tag+ - current html tag to search for
      #
      # * *Returns* :
      #   - A hashmap where the key is the tag and the value is the count in the document
      def get_tag_count(document, tag)
        count = 0
        start_tag_with_attrs_pattern = "(<" + tag + " ([^>]+)>)"
        start_tag_pattern = "<" + tag + ">";
        empty_tag_pattern = "<" + tag + "/>";
        start_tags_attr = document.scan(/#{start_tag_with_attrs_pattern}/i)
        start_tags = document.scan(/#{start_tag_pattern}/i)
        empty_tags = document.scan(/#{empty_tag_pattern}/i)
        count = start_tags_attr.size if start_tags_attr != nil?
        count = count + start_tags.size if start_tags != nil?
        count = count + empty_tags.size if empty_tags != nil?
        count
      end
    end
  end
end
