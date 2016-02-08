require "spec_helper"

RSpec.describe Taggart::Helpers::TagCounter do

  describe "#get_tag_count" do

    let(:html_document) {
      <<-eos
        <html><head><title>Hello there</title></head>
          <body class="test">
            this is a test of the automatic html body
            <table>
              <tr><td></td></tr>
              <tr><td></td></tr>
              <TR><td></td></TR>
              <tr class="test"><td></td></tr>
            </table>
            <paragraph>test</paragraph>
            <p>Another test</p>
            <hr/>
          </body>
        </html>
      eos
    }

    it "should get count for single tag" do
      expect (subject.get_tag_count(html_document, 'html')).should eq(1)
    end

    it "should get count for multiple tags" do
      expect (subject.get_tag_count(html_document, 'td')).should eq(4)
    end

    it "should get count for multiple tags case insensitive" do
      expect (subject.get_tag_count(html_document, 'tr')).should eq(4)
    end

    it "should get count for empty tag" do
      expect (subject.get_tag_count(html_document, 'hr')).should eq(1)
    end

    it "should get count for short tag" do
      expect (subject.get_tag_count(html_document, 'p')).should eq(1)
    end
  end
end

