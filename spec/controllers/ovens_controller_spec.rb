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
        get :index

        expect(assigns(:ovens)).to eq(user.ovens)
      end
    end
  end

  describe 'GET show' do
    let(:oven) { FactoryGirl.create(:oven, user: user) }

    context "when not authenticated" do
      before { sign_in nil }

      it "blocks access" do
        get :show, id: oven.id
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "when authenticated" do
      before { sign_in user }

      it "allows access" do
        get :show, id: oven.id
        expect(response).to_not be_a_redirect
      end

      it "assigns the @oven" do
        get :show, id: oven.id
        expect(assigns(:oven)).to eq(oven)
      end

      context "when requesting someone else's oven" do
        let(:oven) { FactoryGirl.create(:oven) }

        it "blocks access" do
          expect {
            get :show, id: oven.id
          }.to raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end
  end
end
