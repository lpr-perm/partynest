# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CreateRSAKeysAndX509SelfSignedCertificate do
  subject do
    described_class.call(
      distinguished_name: distinguished_name,
      not_before: not_before,
      not_after: not_after,
    )
  end

  let(:distinguished_name) { "CN=#{Faker::Internet.domain_name}" }
  let(:not_before) { Faker::Time.backward.utc }
  let(:not_after) { Faker::Time.forward.utc }

  specify do
    expect { subject }.to change(RSAKey, :count).by(1)
  end

  specify do
    expect { subject }.to change(X509Certificate, :count).by(1)
  end

  specify do
    expect { subject }.to(
      have_enqueued_job(ClearRSAPrivateKeyJob)
      .with do |rsa_key_id|
        expect(rsa_key_id).to equal RSAKey.last.id
      end,
    )
  end

  specify do
    expect(subject.key).to be_instance_of RSAKey
  end

  specify do
    expect(subject.certificate).to be_instance_of X509Certificate
  end

  specify do
    expect(subject.key.private_key_pem).not_to be_blank
  end

  specify do
    expect(subject.key.private_key_pem_secret).not_to be_blank
  end
end
