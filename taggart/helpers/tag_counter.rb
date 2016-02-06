module Taggart
  module Helpers
    class TagCounter


      def initialize()
        #http://www.w3schools.com/tags/
        @valid_tags = ["!--",
                       "!DOCTYPE",
                       "a",
                       "abbr",
                       "acronym",
                       "address",
                       "applet",
                       "area",
                       "article",
                       "aside",
                       "audio",
                       "b",
                       "base",
                       "basefont",
                       "bdi",
                       "bdo",
                       "big",
                       "blockquote",
                       "body",
                       "br",
                       "button",
                       "canvas",
                       "caption",
                       "center",
                       "cite",
                       "code",
                       "col",
                       "colgroup",
                       "datalist",
                       "dd",
                       "del",
                       "details",
                       "dfn",
                       "dialog",
                       "dir",
                       "div",
                       "dl",
                       "dt",
                       "em",
                       "embed",
                       "fieldset",
                       "figcaption",
                       "figure",
                       "font",
                       "footer",
                       "form",
                       "frame",
                       "frameset",
                       "h1",
                       "h2",
                       "h3",
                       "h4",
                       "h5",
                       "h6",
                       "head",
                       "header",
                       "hr",
                       "html",
                       "i",
                       "iframe",
                       "img",
                       "input",
                       "ins",
                       "kbd",
                       "keygen",
                       "label",
                       "legend",
                       "li",
                       "link",
                       "main",
                       "map",
                       "mark",
                       "menu",
                       "menuitem",
                       "meta",
                       "meter",
                       "nav",
                       "noframes",
                       "noscript",
                       "object",
                       "ol",
                       "optgroup",
                       "option",
                       "output",
                       "p",
                       "param",
                       "pre",
                       "progress",
                       "q",
                       "rp",
                       "rt",
                       "ruby",
                       "s",
                       "samp",
                       "script",
                       "section",
                       "select",
                       "small",
                       "source",
                       "span",
                       "strike",
                       "strong",
                       "style",
                       "sub",
                       "summary",
                       "sup",
                       "table",
                       "tbody",
                       "td",
                       "textarea",
                       "tfoot",
                       "th",
                       "thead",
                       "time",
                       "title",
                       "tr",
                       "track",
                       "tt",
                       "u",
                       "ul",
                       "var",
                       "video",
                       "wbr",
        ]

      end

      # For each valid html tag, get its count in the given document.
      # If a tag does not exist in the document it is not included
      #in the count
      def get_tag_counts(document)
        tag_counts = {}
        @valid_tags.each do |t|
          count = get_tag_count(document, t)
          tag_counts[t] = count if count != 0
        end
        tag_counts
      end

      # Get the count of start html tags
      # This will match tags of the following form
      # <body>
      #<body class="xx">
      #<body/>
      # it will not match closing tags, because a complete tag is defined as either an open
      # close tag or a
      #<body></body>
      #<body/>
      def get_tag_count(document, tag)
        count = 0
        pattern = "<#{tag}[>|\s|//]"
        tags_found = document.scan(/#{pattern}/i)
        count = tags_found.size if tags_found != nil?
        count
      end
    end
  end
end
