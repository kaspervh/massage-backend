class ApplicationController < ActionController::API
  
  
  ######################
  # user authorization #
  #####################

  #rails can create a secret
  #this function returns said key 
  SECRET =  Rails.application.secrets.secret_key_base.to_s
  

  # builds a json web token token with the rails generated secret key as the secret 
  def encode_token(payload)
    JWT.encode(payload, 'diller')
  end

  def auth_header
    # { Authorization: 'Bearer <token>' }
    request.headers['Authorization']
  end

  def decoded_token
    if auth_header
      token = auth_header.split(' ')[1]
      # header: { 'Authorization': 'Bearer <token>' }
      begin
        JWT.decode(token, 's3cr3t', true, algorithm: 'HS256')
      rescue JWT::DecodeError
        nil
      end
    end
  end

  def logged_in_user
    if decoded_token
      user_id = decoded_token[0]['user_id']
      @user = User.find_by(id: user_id)
    else
      render json: JWT.decode(auth_header, 's3cr3t')
    end
  end

  def logged_in?
    !!logged_in_user
  end

  def authorize
    render json: { message: 'Please log in' }, status: :unauthorized unless logged_in?
  end


end
