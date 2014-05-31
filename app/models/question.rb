class Question < ActiveRecord::Base
  attr_accessible :answer, :question, :sender_id, :recipient_id, :conversation_id

  belongs_to :user

  belongs_to :sender,:class_name => 'User',:foreign_key => 'sender_id'

  belongs_to :recipient,:class_name => 'User',:foreign_key => 'recipient_id'

  belongs_to :message

  belongs_to :conversation

  end