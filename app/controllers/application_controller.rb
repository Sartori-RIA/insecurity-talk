class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  skip_forgery_protection #TODO UNSAFE - allowing CSRF

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.html do
        redirect_to root_path, alert: "Access Denied"
      end
      format.json do
        render json: { error: "Access Denied" }, status: :forbidden
      end
    end
  end
end
