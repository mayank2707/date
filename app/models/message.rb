class Message < ActiveRecord::Base
	attr_accessible :subject, :body, :sender_id, :recipient_id, :read_at,:sender_deleted,:recipient_deleted
	validates_presence_of :subject, :message => "Please enter message title"

	belongs_to :sender,
	:class_name => 'User',
	:foreign_key => 'sender_id'
	belongs_to :recipient,
	:class_name => 'User',
	:foreign_key => 'recipient_id'

    # marks a message as deleted by either the sender or the recipient, which ever the user that was passed is.
    # When both sender and recipient marks it deleted, it is destroyed.
    def mark_message_deleted(id,user_id)
         self.sender_deleted = true if self.sender_id == user_id
         self.recipient_deleted = true if self.recipient_id == user_id
         (self.sender_deleted && self.recipient_deleted) ? self.destroy : self.save!
     end
    # Read message and if it is read by recipient then mark it is read
    def readingmessage
      self.read_at ||= Time.now
      save
    end
    
    # Based on if a message has been read by it's recipient returns true or false.
    def read?
    	self.read_at.nil? ? false : true
    end

    def self.received_by(user)
       where(:recipient_id => user.id)
     end

     def self.not_recipient_deleted
       where("recipient_deleted = ?", false)
     end

end