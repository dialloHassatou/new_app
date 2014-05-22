require 'spec_helper'
describe "Static pages" do
  describe "Home page" do
    it "should have the content 'New App'" do
      visit '/static_pages/home'
      page.should have_content('New App')
    end
  end
end
