require 'rails_helper'

describe EventPolicy do
  subject { described_class.new(user, event) }
  let(:event) { Event.create }

  context 'being an anon visitor' do
    let(:user) { nil }

    it { is_expected.to permit_action(:show) }
    it { is_expected.to forbid_actions(%i[create update destroy]) }
  end

  context 'being a usual user' do
    context 'an event owner' do
      let(:user) { User.create(events: [event]) }

    it { is_expected.to permit_actions(%i[show create update destroy]) }
  end

    context 'not an event owner' do
      let(:user) { User.create }

      it { is_expected.to permit_actions(%i[show create]) }
      it { is_expected.to forbid_actions(%i[update destroy]) }
    end
  end
end
