class UniqnessController < ApplicationController
  def email_uniqness
    if User.find_by(email: request.params['email'].to_s)
      render status: '302', json: { message: 'Email exist' }
    else
      render status: '204', json: { message: 'Email not found' }
    end
  end
end
