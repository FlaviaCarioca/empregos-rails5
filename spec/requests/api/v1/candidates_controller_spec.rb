require 'rails_helper'

describe API::V1::CandidatesController, type: :request do
  before (:all) do
    user = FactoryGirl.create(:user_candidate)
    @headers = auth_headers(user.id)
  end

  describe 'PUT #update' do
    before(:each) do
      @candidate = {
        address: Faker::Address.street_address,
        city:  Faker::Address.city,
        state: Faker::Address.state_abbr,
        zip: Faker::Address.zip,
        title: 'Software Engineer',
        description: Faker::Lorem.paragraph(2),
        minimum_salary: Faker::Number.number(6),
        linkedin: Faker::Internet.url('linkedin.com', '/someone.html'),
        github: Faker::Internet.url('github.com', '/someone.html'),
        is_active: true,
        can_relocate: false,
        can_remote: true,
        is_visa_needed: false
      }
    end

    it 'updates a candidate' do
      put api_v1_candidate_path, headers: @headers, params: { candidate: @candidate }

      expect(response).to be_success
    end

    it 'returns error if candidate cannot be updated' do
      put api_v1_candidate_path, headers: @headers, params: { candidate: nil }

      expect(response).not_to be_success
      expect(response.status).to eq 500
    end
  end
end
