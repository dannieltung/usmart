class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @payments = Payment.all.sort_by { |event| [event.due_date] }.select do |payment|
      payment.user == current_user
    end
  end
end
