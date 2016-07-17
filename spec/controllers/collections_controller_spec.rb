require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

RSpec.describe CollectionsController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # Collection. As you add validations to Collection, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) do
    {
      name: "TEST NAME",
      description: "TEST DESCRIPTION"
    }
  end

  let(:invalid_attributes) {
    { name: "" }
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # CollectionsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "PUT #update_from_github" do
    issue_params = {
      title: "UPDATED TITLE",
      html_url: "https://github.com/TEST_GITHUB_ACCOUNT/TEST_PROJECT/issues/1",
      labels: [{ name: "UPDATED LABEL ONE"},{ name: "UPDATED LABEL TWO" }]
    }
    let(:issues){ double(Issue, issue_params) }
    let(:github_project) { double(GithubProject) }

    before do
      allow(GithubProject).to receive(:new).and_return(github_project)
      allow(github_project).to receive(:name).and_return("UPDATED NAME")
      allow(github_project).to receive(:description).and_return("UPDATED DESCRIPTION")
      allow(github_project).to receive(:issues).and_return([issues])
      @collection = create :collection
      @project = create :project, collection: @collection
      @issue = create :issue, project: @project
      put :update_from_github, {:id => @collection.to_param}, valid_session
      @project.reload
      @issue.reload
    end

    it "updates the project" do
      expect(@project.name).to eq("UPDATED NAME")
      expect(@project.description).to eq("UPDATED DESCRIPTION")
    end

    it "updates the labels" do
      expect(@issue.title).to eq("UPDATED TITLE")
      expect(@issue.labels).to eq(["UPDATED LABEL ONE","UPDATED LABEL TWO"])
    end
  end

  describe "GET #index" do
    it "assigns all collections as @collections" do
      collection = Collection.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:collections)).to eq([collection])
    end
  end

  describe "GET #show" do
    it "assigns the requested collection as @collection" do
      collection = Collection.create! valid_attributes
      get :show, {:id => collection.to_param}, valid_session
      expect(assigns(:collection)).to eq(collection)
    end

    it "lists that collection's projects" do
      collection = create :collection
      other_collection = create :collection

      create :project, collection: collection
      create :project, collection: collection
      create :project, collection: other_collection

      get :show, {:id => collection.to_param}, valid_session
      expect(assigns[:projects].count).to eq(2)
    end
  end

  describe "GET #issues" do
    it "lists all the collection's issues" do
      create :issue, title: "TEST ISSUE"
      get :issues, {:collection_id => Collection.first.id }, valid_session
      expect(assigns[:issues].first.title).to eq("TEST ISSUE")
      expect(assigns[:collection].id).to eq(Collection.first.id)
    end
  end

  describe "GET #new" do
    it "assigns a new collection as @collection" do
      get :new, {}, valid_session
      expect(assigns(:collection)).to be_a_new(Collection)
    end
  end

  describe "GET #edit" do
    it "assigns the requested collection as @collection" do
      collection = Collection.create! valid_attributes
      get :edit, {:id => collection.to_param}, valid_session
      expect(assigns(:collection)).to eq(collection)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Collection" do
        expect {
          post :create, {:collection => valid_attributes}, valid_session
        }.to change(Collection, :count).by(1)
      end

      it "assigns a newly created collection as @collection" do
        post :create, {:collection => valid_attributes}, valid_session
        expect(assigns(:collection)).to be_a(Collection)
        expect(assigns(:collection)).to be_persisted
      end

      it "redirects to the created collection" do
        post :create, {:collection => valid_attributes}, valid_session
        expect(response).to redirect_to(Collection.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved collection as @collection" do
        post :create, {:collection => invalid_attributes}, valid_session
        expect(assigns(:collection)).to be_a_new(Collection)
      end

      it "re-renders the 'new' template" do
        post :create, {:collection => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        {
          name: "UPDATED NAME",
          description: "UPDATED DESCRIPTION"
        }
      }

      it "updates the requested collection" do
        collection = Collection.create! valid_attributes
        put :update, {:id => collection.to_param, :collection => new_attributes}, valid_session
        collection.reload
        expect(collection.name).to eq("UPDATED NAME")
        expect(collection.description).to eq("UPDATED DESCRIPTION")
      end

      it "assigns the requested collection as @collection" do
        collection = Collection.create! valid_attributes
        put :update, {:id => collection.to_param, :collection => valid_attributes}, valid_session
        expect(assigns(:collection)).to eq(collection)
      end

      it "redirects to the collection" do
        collection = Collection.create! valid_attributes
        put :update, {:id => collection.to_param, :collection => valid_attributes}, valid_session
        expect(response).to redirect_to(collection)
      end
    end

    context "with invalid params" do
      it "assigns the collection as @collection" do
        collection = Collection.create! valid_attributes
        put :update, {:id => collection.to_param, :collection => invalid_attributes}, valid_session
        expect(assigns(:collection)).to eq(collection)
      end

      it "re-renders the 'edit' template" do
        collection = Collection.create! valid_attributes
        put :update, {:id => collection.to_param, :collection => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested collection" do
      collection = Collection.create! valid_attributes
      expect {
        delete :destroy, {:id => collection.to_param}, valid_session
      }.to change(Collection, :count).by(-1)
    end

    it "redirects to the collections list" do
      collection = Collection.create! valid_attributes
      delete :destroy, {:id => collection.to_param}, valid_session
      expect(response).to redirect_to(collections_url)
    end
  end

end
