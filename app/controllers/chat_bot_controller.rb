class ChatBotController < ApplicationController
  def index
    @messages = session[:chat_messages] || []
  end

  def send_message
    message = params[:message]
    
    # Store user message
    session[:chat_messages] ||= []
    session[:chat_messages] << { role: 'user', content: message, timestamp: Time.current }
    
    # AI response placeholder (will be integrated with AI later)
    response = generate_response(message)
    session[:chat_messages] << { role: 'assistant', content: response, timestamp: Time.current }
    
    render json: { 
      success: true, 
      message: response,
      timestamp: Time.current
    }
  end

  private

  def generate_response(message)
    # Placeholder response - will be replaced with actual AI integration
    "Thank you for your question about '#{message}'. This AI Chat Bot is currently in development and will soon be powered by an advanced AI engine that can learn from the handbook materials and your questions. For now, please refer to the Handbook section for detailed information about well intervention operations."
  end
end
