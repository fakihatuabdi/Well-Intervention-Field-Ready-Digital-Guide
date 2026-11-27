module Admin
  class UsersController < BaseController
    before_action :set_user, only: %i[edit update approve unlock]

    def index
      scope = User.order(Arel.sql("CASE WHEN status = 'pending' THEN 0 ELSE 1 END"), :email)
      scope = scope.where(status: params[:status]) if User::STATUSES.include?(params[:status])
      @users = scope.page(params[:page]).per(50)
    end

    def new
      @user = User.new(role: "pengguna", status: "active")
    end

    def create
      @user = User.new(user_params)
      if @user.save
        audit!("user.create", target: @user, details: { role: @user.role, status: @user.status })
        redirect_to admin_users_path, notice: "Account created for #{@user.email}. Give the password to the user in person."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit; end

    def update
      attrs = user_params
      attrs = attrs.except(:password, :password_confirmation) if attrs[:password].blank?

      if removes_last_admin?(attrs)
        @user.assign_attributes(attrs.except(:password, :password_confirmation))
        @user.errors.add(:base, "At least one active admin is required. Make another user admin first.")
        return render :edit, status: :unprocessable_entity
      end

      if @user.update(attrs)
        details = change_summary(@user)
        details["password"] = "reset by admin" if attrs[:password].present?
        audit!("user.update", target: @user, details: details)
        redirect_to admin_users_path, notice: "Account #{@user.email} saved."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def approve
      @user.update!(status: "active")
      audit!("user.approve", target: @user)
      redirect_to admin_users_path, notice: "#{@user.email} can now sign in.", status: :see_other
    end

    def unlock
      @user.unlock_access!
      audit!("user.unlock", target: @user)
      redirect_to admin_users_path, notice: "#{@user.email} is unlocked.", status: :see_other
    end

    private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email, :role, :status, :password, :password_confirmation)
    end

    def removes_last_admin?(attrs)
      return false unless @user.last_active_admin?

      (attrs.key?(:role) && attrs[:role] != "admin") || (attrs.key?(:status) && attrs[:status] != "active")
    end
  end
end
