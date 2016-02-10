require "spec_helper"

RSpec.describe Taggart::Helpers::StrictTagCounter do

  describe "get_tag_counts" do
    let(:html_document) {
      <<-eos
        <!DOCTYPE html>
        <html><head><title>Hello there</title></head>
          <body class="test">
          <hr/>
          <HR/>
          </body>
          <random>I am not a html tag but should match on pattern</random>
          <random class = 'test'>I am not a html tag but should match on pattern</random>
          <random/>
        </html>
      eos
    }

    it "should get counts for valid html tags" do
      tag_counts = subject.get_tag_counts(html_document)
      expect (tag_counts['!DOCTYPE']).should eq(1)
      expect (tag_counts['html']).should eq(1)
      expect (tag_counts['head']).should eq(1)
      expect (tag_counts['title']).should eq(1)
      expect (tag_counts['hr']).should eq(2)
      expect (tag_counts['random']).should eq(nil)
    end
  end
end

