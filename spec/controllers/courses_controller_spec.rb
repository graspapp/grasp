require 'spec_helper'

describe CoursesController do
  describe "GET #new" do
    it "assigns a new Course to @course" do
      get :new
      expect(assigns(:course)).to be_instance_of Course
    end

    it "renders the :new template" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe "GET #show" do
    it "assigns the requested course to @course" do
      contact = FactoryGirl.create(:course)
      get :show, id: contact
      expect(assigns(:course)).to eq contact
    end

    it "renders the :show template" do
      get :show, id: FactoryGirl.create(:course)
      expect(response).to render_template :show
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "saves the new course in the database" do
        expect {
          post :create, course: FactoryGirl.attributes_for(:course)
        }.to change(Course, :count).by 1
      end

      it "redirects to the homepage" do
        post :create, course: FactoryGirl.attributes_for(:course)
        expect(reponse).to redirect_to root_path
      end
    end

    context "with invalid attributes" do
      it "does not save the new course in the database"
      it "re-renders the new template"
    end
  end
end
