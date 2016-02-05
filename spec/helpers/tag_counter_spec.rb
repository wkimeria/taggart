require "spec_helper"

RSpec.describe Taggart::Helpers::TagCounter do

  describe "#is_start_tag" do

    it "should return true if is start tag" do
      expect (subject.is_start_tag('<html>')).should be_truthy
    end

    it "should return true if empty tag" do
      expect (subject.is_start_tag('<hr/>')).should be_truthy
    end

    it "should return false if is not start tag" do
      expect (subject.is_start_tag('</html>')).should be_falsey
    end
  end
end

