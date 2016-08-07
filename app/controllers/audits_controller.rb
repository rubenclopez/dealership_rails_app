class AuditsController < ApplicationController
  respond_to :json, :html

  before_action :authenticate_user!
  before_action :check_roles

  def index
    @audits = Audit.all.map(&:attributes).map(&:with_indifferent_access).map do |audit|
      audit[:seller_id] = audit[:user_id]

      audit.merge!(seller_id: audit[:user_id], sold_on: audit[:created_at])
    end

    respond_with(@audits)
  end

  private

  def check_roles
    if current_user.roles.include?(Role['owner'])
      true
    else
      redirect_to root_path
    end
  end
end
