class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @payments = Payment.where("due_date > ?", (Date.today - 1.week)).sort_by { |event| [event.due_date, event.description] }.select do |payment|
      payment.user == current_user
    end
  end
end
