require 'rails_helper'

RSpec.describe "issues/new", type: :view do
  before(:each) do
    assign(:issue, Issue.new(
      :title => "MyString",
      :url => "MyString",
      :body => "MyText",
      :labels => "",
      :project => nil
    ))
  end

  it "renders new issue form" do
    render

    assert_select "form[action=?][method=?]", issues_path, "post" do

      assert_select "input#issue_title[name=?]", "issue[title]"

      assert_select "input#issue_url[name=?]", "issue[url]"

      assert_select "textarea#issue_body[name=?]", "issue[body]"

      assert_select "input#issue_labels[name=?]", "issue[labels]"

      assert_select "input#issue_project_id[name=?]", "issue[project_id]"
    end
  end
end