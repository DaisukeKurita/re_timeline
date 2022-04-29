require 'rails_helper'

RSpec.describe Map, type: :model do
  describe 'Map機能' do
    context '正しく情報が入力されている' do
      it 'Map情報が登録される' do
        map = FactoryBot.build(:map, address: "沼津駅", latitude: 35.1026494, longitude: 138.8598006, event_time: "2000-01-01 13:00:00" )
        expect(map).to be_valid
      end
    end
  end
end
