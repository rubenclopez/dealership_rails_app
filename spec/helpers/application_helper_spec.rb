require 'rails_helper'

describe ApplicationHelper, type: :helper do
  context "#render_link" do
    before do
      allow(self).to receive("current_page?") { true }
    end

    it "should include the correct path" do
      expect(render_link('test', '/my_path')).to match(/my_path/)
    end

    it "should include the correct text" do
      expect(render_link('abc', '/my_path')).to match(/abc/)
    end

    it "should include the correct class" do
      expect(render_link('abc', '/my_path')).to match(/class=\"active\"/)
    end

    it "should include the correct class when not the current page" do
      allow(self).to receive("current_page?") { false }
      expect(render_link('abc', '/my_path')).to_not match(/class=\"active\"/)
    end
  end
end