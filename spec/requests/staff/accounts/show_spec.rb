# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GET /staff/accounts/:nickname' do
  let!(:some_account) { create :usual_account }
  let(:current_account) { create :usual_account }

  def make_request
    get "/staff/accounts/#{some_account.nickname}"
  end

  before do
    sign_in current_account.user if current_account&.user
    make_request
  end

  for_account_types nil, :usual do
    specify do
      expect(response).to have_http_status :forbidden
    end
  end

  for_account_types :superuser do
    specify do
      expect(response).to have_http_status :ok
    end
  end
end
