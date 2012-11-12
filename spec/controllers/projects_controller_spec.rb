require 'spec_helper'

describe ProjectsController do
  include Devise::TestHelpers

  let(:user) { FactoryGirl.create(:user) }
  before :each do
    sign_in user
  end

  describe '#create' do
    context "when the project is valid" do

    end

    context "when the project is not valid" do
      it "re-renders the 'new' template" do
        Project.any_instance.stub(:save).and_return(false)
        post(:create, :project => { :name => 'a project', :description => 'a description' })
        response.should render_template('projects/new')
      end
    end

  end
end