class CouponsController < ApplicationController
  def index
    #トップページが表示された時はデフォルトとして現在地を表示させる
    #入力された住所を一旦、座標に変換してDBに登録する
    @latitude = '35.6585805'

    @longitude = '139.7454329'

    @address = '〒105-0011 東京都港区芝公園４丁目２-８'

    #Google MapのAPIキーを取得する
    @gmapkey = ENV["GOOGLE_MAP_API"]
  end
end
