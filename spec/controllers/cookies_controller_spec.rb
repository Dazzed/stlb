require 'spec_helper'

describe CookiesController do
  let(:user) { FactoryGirl.create(:user) }
  let(:oven) { user.ovens.first }

  describe 'GET new' do
    context "when not authenticated" do
      before { sign_in nil }

      it "blocks access" do
        get :new, oven_id: oven.id
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "when authenticated" do
      before { sign_in user }

      it "allows access" do
        get :new, oven_id: oven.id
        expect(response).to_not be_a_redirect
      end

      context "when a valid oven is supplied" do
        it "assigns @oven" do
          get :new, oven_id: oven.id

          expect(assigns(:oven)).to eq(oven)
        end

        it "assigns a new @cookie" do
          get :new, oven_id: oven.id

          cookie = assigns(:cookie)
          expect(cookie).to_not be_persisted
          expect(cookie.oven).to eq(oven)
        end
      end

      context "when an invalid oven is supplied" do
        it "is not successful" do
          expect {
            get :new, oven_id: FactoryGirl.create(:oven).id
          }.to raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end
  end

  describe 'POST create' do
    let(:cookie_params) do
      {
        fillings: 'Vanilla'
      }
    end

    context "when not authenticated" do
      before { sign_in nil }

      it "blocks access" do
        post :create, oven_id: oven.id, cookie: cookie_params
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "when authenticated" do
      before { sign_in user }

      it "allows access" do
        expect {
          post :create, oven_id: oven.id, cookie: cookie_params
        }.to_not raise_error
      end

      context "when a valid oven is supplied" do
        it "creates a cookie for that oven" do
          expect {
            post :create, oven_id: oven.id, cookie: cookie_params
          }.to change{Cookie.count}.by(1)

          expect(Cookie.last.oven).to eq(oven)
        end

        it "redirects to the oven" do
          post :create, oven_id: oven.id, cookie: cookie_params
          expect(response).to redirect_to oven_path(oven)
        end

        it "assigns valid cookie parameters" do
          post :create, oven_id: oven.id, cookie: cookie_params
          expect(Cookie.last.fillings).to eq(cookie_params[:fillings])
        end
      end

      context "when an invalid oven is supplied" do
        it "is not successful" do
          expect {
            post :create, oven_id: FactoryGirl.create(:oven).id, cookie: cookie_params
          }.to raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end

  end
end
