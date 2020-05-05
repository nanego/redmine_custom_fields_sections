require "spec_helper"

describe CustomFieldsSectionsController, :type => :controller do

  fixtures :roles, :users

  before do
    @request.session[:user_id] = 1 # Admin
    User.current = User.find(1)
    Setting.default_language = 'en'
    CustomFieldsSection.create!(name: "Test section")
  end

  describe "#index" do
    it "should display index correctly as admin" do
      get :index

      expect(response).to have_http_status(:success)
      expect(assigns(:custom_fields_sections)).to exist
      expect(assigns(:custom_fields_sections).count).to eq(1)
      expect(assigns(:custom_fields_sections)).to match_array(CustomFieldsSection.all)
      expect(response).to render_template(:index)
    end

    it "should not be available only as admin users" do
      @request.session[:user_id] = 2

      get :index

      expect(response).to have_http_status(:forbidden)
      expect(response).to render_template("common/error")
    end
  end

  describe "#new" do
    it "should display new correctly as admin" do
      get :new

      expect(response).to have_http_status(:success)
      expect(assigns(:custom_fields_section)).to be_present
      expect(assigns(:custom_fields_section).name).to be_nil
      expect(response).to render_template(:new)
    end

    it "should not be available only as admin users" do
      @request.session[:user_id] = 2

      get :new

      expect(response).to have_http_status(:forbidden)
      expect(response).to render_template("common/error")
    end
  end

  describe "#create" do
    it "should redirect if section created correctly as admin" do
      post :create, :params => { :custom_fields_section => { :name => "Test create" } }

      expect(response).to have_http_status(:redirect)
      expect(assigns(:custom_fields_section).id).to be_present
      expect(assigns(:custom_fields_section).name).to eq("Test create")
      expect(response).to redirect_to custom_fields_sections_url
    end

    it "should render new if section not created correctly as admin" do
      post :create, :params => { :custom_fields_section => { :name => "" } }

      expect(response).to have_http_status(:ok)
      expect(assigns(:custom_fields_section).id).to be_nil
      expect(response).to render_template(:new)
    end

    it "should not be available only as admin users" do
      @request.session[:user_id] = 2

      post :create, :params => { :custom_fields_section => { :name => "Test create" } }

      expect(response).to have_http_status(:forbidden)
      expect(response).to render_template("common/error")
    end
  end

  describe "#edit" do
    it "should display edit existing section as admin" do
      get :edit, :params => { :id => CustomFieldsSection.first.id }

      expect(response).to have_http_status(:success)
      expect(assigns(:custom_fields_section)).to be_present
      expect(assigns(:custom_fields_section).name).to eq("Test section")
      expect(response).to render_template(:edit)
    end

    it "should not display edit not existing section as admin" do
      expect { get :edit, :params => { :id => "100" } }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it "should not be available only as admin users" do
      @request.session[:user_id] = 2

      get :edit, :params => { :id => CustomFieldsSection.first.id }

      expect(response).to have_http_status(:forbidden)
      expect(response).to render_template("common/error")
    end
  end

  describe "#update" do
    it "should redirect if section updated correctly as admin" do
      post :update, :params => { :id => CustomFieldsSection.first.id, :custom_fields_section => { :name => "Test up" } }

      expect(response).to have_http_status(:redirect)
      expect(assigns(:custom_fields_section).id).to be_present
      expect(assigns(:custom_fields_section).name).to eq("Test up")
      expect(response).to redirect_to custom_fields_sections_url
    end

    it "should render new if section not created correctly as admin" do
      post :update, :params => { :id => CustomFieldsSection.first.id, :custom_fields_section => { :name => "" } }

      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:edit)
    end

    it "should not be available only as admin users" do
      @request.session[:user_id] = 2

      post :update, :params => { :id => CustomFieldsSection.first.id, :custom_fields_section => { :name => "Test up" } }

      expect(response).to have_http_status(:forbidden)
      expect(response).to render_template("common/error")
    end
  end

  describe "#destroy" do
    it "should destroy existing section as admin" do
      delete :destroy, :params => { :id => CustomFieldsSection.first.id }

      expect(response).to have_http_status(:redirect)
      expect(assigns(:custom_fields_section)).to be_present
      expect(assigns(:custom_fields_section).name).to eq("Test section")
      expect(response).to redirect_to custom_fields_sections_url
    end

    it "should not destroy not existing section as admin" do
      expect { delete :destroy, :params => { :id => "100" } }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it "should not be available only as admin users" do
      @request.session[:user_id] = 2

      delete :destroy, :params => { :id => CustomFieldsSection.first.id }

      expect(response).to have_http_status(:forbidden)
      expect(response).to render_template("common/error")
    end
  end
end
