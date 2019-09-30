# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OrgUnit do
  subject { create :some_children_org_unit }

  describe '#kind' do
    it do
      is_expected.to \
        belong_to(:kind)
        .class_name('OrgUnitKind')
        .inverse_of(:instances)
        .required
    end

    it { is_expected.to validate_presence_of(:kind).with_message(:required) }
  end

  describe '#parent' do
    it do
      is_expected.to \
        belong_to(:parent)
        .class_name('OrgUnit')
        .inverse_of(:children)
    end

    context 'when organizational unit type does not require parent' do
      subject { create :some_root_org_unit }

      it do
        is_expected.not_to validate_presence_of(:parent).with_message(:required)
      end
    end

    context 'when organizational unit type does not require parent' do
      subject { create :some_children_org_unit }

      it do
        is_expected.to validate_presence_of(:parent).with_message(:required)
      end
    end
  end

  describe '#short_name' do
    def allow_value(*)
      super.for :short_name
    end

    it { is_expected.to validate_presence_of :short_name }
    it { is_expected.to validate_uniqueness_of :short_name }

    it do
      is_expected.to \
        validate_length_of(:short_name)
        .is_at_least(1)
        .is_at_most(255)
    end

    it { is_expected.not_to allow_value nil }
    it { is_expected.not_to allow_value '' }
    it { is_expected.not_to allow_value ' ' }

    it { is_expected.to allow_value Faker::Name.name }
    it { is_expected.to allow_value Faker::Name.first_name }
    it { is_expected.to allow_value 'Foo Bar' }

    it { is_expected.not_to allow_value ' Foo' }
    it { is_expected.not_to allow_value 'Foo ' }
    it { is_expected.not_to allow_value "\tFoo" }
    it { is_expected.not_to allow_value "Foo\t" }
    it { is_expected.not_to allow_value "\nFoo" }
    it { is_expected.not_to allow_value "Foo\n" }
  end

  describe '#name' do
    def allow_value(*)
      super.for :name
    end

    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_uniqueness_of :name }

    it do
      is_expected.to \
        validate_length_of(:name)
        .is_at_least(1)
        .is_at_most(255)
    end

    it { is_expected.not_to allow_value nil }
    it { is_expected.not_to allow_value '' }
    it { is_expected.not_to allow_value ' ' }

    it { is_expected.to allow_value Faker::Name.name }
    it { is_expected.to allow_value Faker::Name.first_name }
    it { is_expected.to allow_value 'Foo Bar' }

    it { is_expected.not_to allow_value ' Foo' }
    it { is_expected.not_to allow_value 'Foo ' }
    it { is_expected.not_to allow_value "\tFoo" }
    it { is_expected.not_to allow_value "Foo\t" }
    it { is_expected.not_to allow_value "\nFoo" }
    it { is_expected.not_to allow_value "Foo\n" }
  end
end