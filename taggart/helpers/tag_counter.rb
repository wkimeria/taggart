module Taggart
  module Helpers
    class TagCounter

      def parse(document)
        validate(document)
        tag_info = get_all_tags(document)
        @tag_counts = get_tag_counts_and_pos(tag_info)
      end

      public :parse

      # TODO: Validate that document is a valid HMTL Document
      def validate(document)

      end

      # Get all tags in document as well as their start/end pos (< > </>) included.
      # This treats opening and closing tags as 2 separate tags, so <br> hello</br>
      # counts as 2 tags
      def get_all_tags(document)

        #Error checking, make sure this is a html document
        tag_pos = []
        counter = 0
        element = ""
        start_tag = false

        return tag_pos if document.nil? || document.length == 0

        document.split("").each do |c|
          element = element + c if start_tag
          counter = counter + 1
          if c == "<"
            start_tag = true
            element = element + c
          end

          if c == ">"
            start_tag = false
            tag_pos << [element.downcase, [counter - element.length, counter]]
            element = ""
          end
        end
        tag_pos
      end

      def get_tag_counts_and_pos(tags)
        tag_counts = {}
        tags.each do |t|
          raw_tag = t[0]
          tag_count = t[1]

          whole_tag = raw_tag.gsub /\/|<|>/, ''
          tag = whole_tag.split(" ")[0]

          count = 0
          if is_start_tag(raw_tag)
            count = count + 1
          end

          if !tag_counts.include?(tag)
            tag_counts[tag] = {"count" => count, "positions" => [tag_count]}
          else
            existingTag = tag_counts[tag]
            count = existingTag["count"] + count
            positions = existingTag["positions"] << tag_count
            tag_counts[tag] = {"count" => count, "positions" => positions}
          end

        end
        tag_counts
      end

      # Determine whether a tag is a start tag, defined as either
      # <head> or an empty tag like <hr/>. This is used if we
      # consider a single tag to be both the opening and closing
      # tag i.e <html></html> rather than counting opening and
      # closing tags separately
      def is_start_tag(tag)
        tag.slice(0, 2) != "</" || tag.slice(tag.length-2, tag.length-1) == "/>"
      end
    end
  end
end
