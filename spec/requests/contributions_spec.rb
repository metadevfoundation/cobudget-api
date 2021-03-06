require 'rails_helper'

describe "Buckets" do
  let(:contribution_user) { user }

  describe "POST /contributions" do
    let(:contribution_params) { {
      contribution: {
        bucket_id: round.id,
        user_id: contribution_user.id,
        amount: "25"
      }
    }.to_json }

    it "user creates a contribution for themselves" do
      post "/contributions", contribution_params, request_headers
      contribution = Contribution.first
      expect(response.status).to eq 201
      expect(contribution.amount).to eq 25
      expect(contribution.user).to eq user
    end

    context 'trying to create a contribution for another user' do
      let(:contribution_user) { FactoryGirl.create(:user) }

      it "creates one for the current user instead" do
        post "/contributions", contribution_params, request_headers
        contribution = Contribution.first
        expect(contribution).not_to eq contribution_user
        expect(contribution.user).to eq user
      end
    end
  end

  describe "PUT /contributions" do
    let(:contribution_hash) {
      {
        bucket_id: round.id,
        user_id: contribution_user.id,
        amount: 15
      }
    }

    it "user updates a contribution for themselves" do
      contribution = Contribution.create contribution_hash

      contribution_hash['amount'] = "45"

      put "/contributions/#{contribution.id}", {
        contribution: contribution_hash
      }.to_json, request_headers

      expect(response.status).to eq 204
      contribution = Contribution.first
      expect(contribution.amount).to eq 45
      expect(contribution.user).to eq user
    end
  end

  describe "DELETE /contributions/:id" do
    let(:contribution_hash) {
      {
        bucket_id: round.id,
        user_id: contribution_user.id,
        amount: 25
      }
    }

    it "user deletes a contribution" do
      contribution = Contribution.create contribution_hash
      expect(Contribution.count).to eq 1
      delete "/contributions/#{contribution.id}", {}, request_headers
      expect(response.status).to eq 204
      expect(Contribution.count).to eq 0
    end
  end
end
