require 'rails_helper'

RSpec.describe Grouping, type: :model do
  describe 'グルーピング登録' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:user2) { FactoryBot.create(:user2) }
    let!(:group) { FactoryBot.create(:group)}
    let!(:group2) { FactoryBot.create(:group2)}

    context 'UserとGroupを紐付け' do
      it 'UserとGroupがGroupingされる' do
        grouping = FactoryBot.build(:grouping, user: user, group: group)
        expect(grouping).to be_valid
      end
    end
  end
end
