require 'spec_helper'

describe OvensController do
  let(:user) { FactoryGirl.create(:user) }

  describe 'GET index' do
    context "when not authenticated" do
      before { sign_in nil }

      it "blocks access" do
        get :index
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "when authenticated" do
      before { sign_in user }

      it "allows access" do
        get :index
        expect(response).to_not be_a_redirect
      end

      it "assigns the user's ovens" do
        user.ovens << FactoryGirl.build(:oven)
        get :index

        expect(assigns(:ovens)).to eq(user.ovens)
      end
    end
  end
end
