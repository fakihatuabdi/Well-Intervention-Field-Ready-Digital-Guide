class ChatBotController < ApplicationController
  before_action :set_session_id
  
  def index
    user = current_user if defined?(current_user)
    @messages = if user
      ChatMessage.for_user(user)
    else
      ChatMessage.for_session(@session_id)
    end
  rescue => e
    Rails.logger.error "Error loading chat: #{e.message}"
    flash.now[:alert] = "An error occurred loading chat history."
    @messages = []
  end

  def send_message
    message_content = params[:message]
    return render json: { success: false, error: 'Message cannot be blank' }, status: :unprocessable_entity if message_content.blank?
    
    user = current_user if defined?(current_user)
    
    # Store user message
    user_message = ChatMessage.create!(
      user: user,
      session_id: user ? nil : @session_id,
      role: 'user',
      message: message_content
    )
    
    # Generate AI response
    response_content = generate_response(message_content)
    
    # Store assistant response
    assistant_message = ChatMessage.create!(
      user: user,
      session_id: user ? nil : @session_id,
      role: 'assistant',
      message: response_content
    )
    
    render json: { 
      success: true, 
      message: response_content,
      timestamp: assistant_message.created_at
    }
  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.error "Validation error in chat: #{e.message}"
    render json: { success: false, error: e.message }, status: :unprocessable_entity
  rescue => e
    Rails.logger.error "Error in chat: #{e.message}"
    render json: { success: false, error: 'Failed to send message' }, status: :internal_server_error
  end

  private
  
  def set_session_id
    @session_id = session[:chat_session_id] ||= SecureRandom.uuid
  end

  def generate_response(message)
    # Placeholder response - will be replaced with actual AI integration
    "Thank you for your question about '#{message}'. This AI Chat Bot is currently in development and will soon be powered by an advanced AI engine that can learn from the handbook materials and your questions. For now, please refer to the Handbook section for detailed information about well intervention operations."
  end
end
