# frozen_string_literal: true

class UnsafeLoginController < ApplicationController
  def create
    user = User.find_by("email = #{params[:email]}")

  end
end
