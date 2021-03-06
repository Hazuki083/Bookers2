class GroupsController < ApplicationController

  def new
    @group = Group.new
    @group.users << current_user
    
  end

  def index
    @groups = Group.all.order(updated_at: :desc)
  end

  def edit
  end

  def update
  end

  def create
    if Group.create(group_params)
      redirect_to user_groups_path(@user.id), notice: 'グループを作成しました'
    else
      render :new
    end
  end
  #   @group = Group.new(group_params)
  #   if @group.save
  #     flash[:notice] = "グループを作成しました"
  #     redirect_to user_path(@user.id)
  #   else
  #     render :new
  #   end
  # end

  private

  def group_params
    params.requie(:group).permit(:name, :image, :introduction)
  end

end
