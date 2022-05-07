class ChatsController < ApplicationController

  def show
    @user = User.find(params[:id])
    # チャット相手の特定
    rooms = current_user.user_rooms.pluck(:room_id)
    # 自分(current_user)に紐付くRoomを全て取得
    user_room = UserRoom.find_by(user_id: @user.id, room_id: rooms)
    # チャット相手と共通のRoomを持つ中間テーブルがあるか確認
    if user_room.nil?      
      # 共通のチャットルームがない場合 
      @room = Room.new
      @room.save
      # そのルームidを共通してもつ中間テーブルを、相手と自分の2人分作る
      UserRoom.create(user_id: @user.id, room_id: @room.id)
      UserRoom.create(user_id: current_user.id, room_id: @room.id)
    else
      #共通のチャットルームがあれば、それに紐付くroomを「@room」に代入する
      @room = user_room.room
    end
    # チャット履歴(@chats)の取得」「新規投稿用の空インスタンス(@chat)作成」
    @chats = @room.chats.order(created_at: :desc).kaminari(params[:page]).per(10)
    @chat = Chat.new(room_id: @room.id)
  end

  def create
    @chat = Chat.new(chat_params)
    # ストロングパラメーターを引数に@chatを生成    
    respond_to do |format|
    # save状況に応じて返すビューを条件分岐する。
      if @chat.save
        format.html { redirect_to @chat }
        format.js
        # HTMLで返す場合、showアクションを実行し詳細ページを表示
        # create.js.erbが呼び出される
      else
        format.html { render :show } 
        # HTMLで返す場合、show.html.erbを表示
        format.js { render :errors } 
        # 一番最後に実装の解説があります
      end
    end
  end

  private 
  # 入力内容をストロングパラメータで受け取る
  def chat_params
    params.require(:chat).permit(:message, :room_id).merge(user_id: current_user.id)
  end

end
