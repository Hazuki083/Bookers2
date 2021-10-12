class GroupsController < ApplicationController

  def new
    @group = Group.new
    @group.users << current_user

  end

  def index
    @groups = Group.all
  end

  def edit
  end

  def update
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      redirect_to root_path, notice: 'グループを作成しました'
    else
      render :new
    end
  end

  private

  def group_params
    params.requie(:group).permit(:name, :image, :introduction)
  end

end
