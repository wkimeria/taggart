require "spec_helper"

describe Taggart::Helpers::TagCounter do
  subject do
    Taggart::Helpers::TagCounter.new(nil)
  end

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
          <random>I am not a html tag but should match on pattern</random>
          <random class = 'test'>I am not a html tag but should match on pattern</random>
          <random/>
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

    it "should get count for non html tag" do
      expect (subject.get_tag_count(html_document, 'random')).should eq(3)
    end
  end

  describe "get_tag_counts" do
    let(:html_document) {
      <<-eos
        <html><head><title>Hello there</title></head>
          <body class="test">
          </hr>
          </body>
          <random>I am not a html tag but should match on pattern</random>
          <random class = 'test'>I am not a html tag but should match on pattern</random>
          <random/>
        </html>
      eos
    }
  end
end

