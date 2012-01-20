class Message
  include Mongoid::Document
  include Mongoid::Timestamps
  require 'thread'

  def self.generate_message_id
    1 + Message.count
  end

  def self.list_all_messages
    self.all(sort: [[ :created_at, :desc ]])
  end

  def self.delete_message(mid)
    message = Message.find(mid)
    message.destroy
  end

  def self.create_new_message user_id, content
    u = User.where(uid: user_id).first
    @message = Message.new :mid => self.generate_message_id.to_s, :content => content
    @message.user = u.id
    @message.save
  end

  # def self.create_messages
  #   (0..10).each do |u|
  #     (0..1000).each do |f|
  #       self.new f
  #     end
  #   end
  # end

  field :mid, :type => String, :default => self.generate_message_id.to_s
  field :content, :type => String

  index :id, unique: true

  validates_presence_of :content

  attr_accessible :content

  belongs_to :user

end
