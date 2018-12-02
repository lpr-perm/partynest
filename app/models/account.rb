# frozen_string_literal: true

class Account < ApplicationRecord
  rolify role_join_table_name: 'account_roles'

  has_one :user, dependent: :restrict_with_exception

  has_many :passport_confirmations, dependent: :restrict_with_exception
end