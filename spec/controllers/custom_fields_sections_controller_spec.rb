require "spec_helper"

describe CustomFieldsSectionsController, type: :controller do

  fixtures :roles, :users

  before do
    @request.session[:user_id] = 1 # Admin
    User.current = User.find(1)
    Setting.default_language = "en"
  end

  let (:section) { CustomFieldsSection.create(name: "Test section") }
  let(:custom_fields) do
    [
      ProjectCustomField.create!(name: "field1", section: section, field_format: "string"),
      ProjectCustomField.create!(name: "field2", section: section, field_format: "string"),
      ProjectCustomField.create!(name: "field", field_format: "string")
    ]
  end

  describe "#index" do
    before { section }

    it "should display index correctly as admin" do
      get :index

      expect(response).to have_http_status(:success)
      expect(assigns(:custom_fields_sections)).to exist
      expect(assigns(:custom_fields_sections).count).to eq(1)
      expect(assigns(:custom_fields_sections)).to match_array([section])
      expect(response).to render_template(:index)
    end

    it "should be available only as admin users" do
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

    it "should be available only as admin users" do
      @request.session[:user_id] = 2

      get :new

      expect(response).to have_http_status(:forbidden)
      expect(response).to render_template("common/error")
    end
  end

  describe "#create" do
    before { section }

    it "should redirect if section created correctly as admin" do
      post :create, params: { custom_fields_section: { name: "Test create" } }

      expect(response).to have_http_status(:redirect)
      expect(assigns(:custom_fields_section).id).to be_present
      expect(assigns(:custom_fields_section).name).to eq("Test create")
      expect(response).to redirect_to custom_fields_sections_url
    end

    it "should render new if section not created correctly as admin" do
      post :create, params: { custom_fields_section: { name: "Test section" } }

      expect(response).to have_http_status(:ok)
      expect(assigns(:custom_fields_section).id).to be_nil
      expect(response).to render_template(:new)
    end

    it "should be available only as admin users" do
      @request.session[:user_id] = 2

      post :create, params: { custom_fields_section: { name: "Test create" } }

      expect(response).to have_http_status(:forbidden)
      expect(response).to render_template("common/error")
    end
  end

  describe "#edit" do
    before do
      section
      custom_fields
    end

    it "should display edit existing section as admin" do
      get :edit, params: { id: section.id }

      expect(response).to have_http_status(:success)
      expect(assigns(:custom_fields_section)).to be_present
      expect(assigns(:custom_fields_section).name).to eq("Test section")
      expect(response).to render_template(:edit)
    end

    it "should not display edit not existing section as admin" do
      expect { get :edit, params: { id: "100" } }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it "should reorder fields as admin" do
      custom_fields.last.update(position: 3)

      get :edit, params: { id: section.id }

      expect(section.project_custom_fields.sort.last.position).to eq(2)
    end

    it "should be available only as admin users" do
      @request.session[:user_id] = 2

      get :edit, params: { id: section.id }

      expect(response).to have_http_status(:forbidden)
      expect(response).to render_template("common/error")
    end
  end

  describe "#update" do
    it "should redirect if section updated correctly as admin" do
      post :update, params: { id: section.id, custom_fields_section: { name: "Test update" } }

      expect(response).to have_http_status(:redirect)
      expect(assigns(:custom_fields_section).id).to be_present
      expect(assigns(:custom_fields_section).name).to eq("Test update")
      expect(response).to redirect_to custom_fields_sections_url
    end

    it "should render new if section not created correctly as admin" do
      post :update, params: { id: section.id, custom_fields_section: { name: "" } }

      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:edit)
    end

    it "should be available only as admin users" do
      @request.session[:user_id] = 2

      post :update, params: { id: section.id, custom_fields_section: { name: "Test update" } }

      expect(response).to have_http_status(:forbidden)
      expect(response).to render_template("common/error")
    end
  end

  describe "#destroy" do
    it "should destroy existing section as admin" do
      delete :destroy, params: { id: section.id }

      expect(response).to have_http_status(:redirect)
      expect(assigns(:custom_fields_section)).to be_present
      expect(assigns(:custom_fields_section).name).to eq("Test section")
      expect(response).to redirect_to custom_fields_sections_url
    end

    it "should not destroy not existing section as admin" do
      expect { delete :destroy, params: { id: "100" } }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it "should be available only as admin users" do
      @request.session[:user_id] = 2

      delete :destroy, params: { id: section.id }

      expect(response).to have_http_status(:forbidden)
      expect(response).to render_template("common/error")
    end
  end

  describe "#order" do
    before do
      section
      custom_fields
    end

    it "should update section fields position" do
      put :order, params: { id: section.id, custom_fields_section: { position: "2" }, format: :js }

      expect(section.project_custom_fields.sort.first.position).to eq(2)
      expect(section.project_custom_fields.sort.last.position).to eq(3)
    end

    it "should not change order on a not existing section as admin" do
      expect { put :order, params: { id: "100", custom_fields_section: { position: "2" }, format: :js } }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it "should not change order if no params[:position] as admin" do
      expect { put :order, params: { id: section.id, custom_fields_section: { }, format: :js } }.to raise_error(ActionController::ParameterMissing)
    end

    it "should be available only as admin users" do
      @request.session[:user_id] = 2

      put :order, params: { id: section.id, custom_fields_section: { position: "2" }, format: :js }

      expect(response).to have_http_status(:forbidden)
    end
  end
end
