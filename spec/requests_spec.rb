# spec/app_spec.rb
require File.expand_path '../spec_helper.rb', __FILE__

describe "Test GitHub Action" do
  it "returns appropriate text for index page" do
    get '/'

    expect(last_response.body).to eq "test: Hello there! My secret is 123"
  end
end
