class EventsController < ApplicationController
  def index
    @events = Event.includes(:owner).where('start_time > ?', Time.zone.now).order(:start_time)
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = current_user.events.build
  end 

  def create
    @event = current_user.events.build(event_params)
    if @event.save
      redirect_to root_path, notice: 'イベントを作成しました'
    else
      render :new
    end
  end

  def edit
    @event = current_user.events.find(params[:id])
  end

  def update
    @event = current_user.events.find(params[:id])
    if @event.update(event_params)
      redirect_to @event, notice: 'イベントを更新しました'
    else
      render :edit
    end
  end

  def destroy
    @event = current_user.events.find(params[:id])
    @event.destroy
    redirect_to root_path, notice: '削除しました'
  end

  private

    def event_params
      params.require(:event).permit(:name, :place, :content, :start_time, :end_time)
    end

end
