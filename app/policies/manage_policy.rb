class ManagePolicy
  def initialize(user, record)
    @user = user
    @record = record
  end

  def show?
    false
  end
end
