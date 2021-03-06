# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GET /settings/person' do
  before do
    sign_in current_account.user if current_account&.user
    get '/settings/person'
  end

  for_account_types nil do
    specify do
      expect(response).to have_http_status :forbidden
    end
  end

  for_account_types :usual, :superuser, :personal do
    specify do
      expect(response).to have_http_status :ok
    end
  end
end
