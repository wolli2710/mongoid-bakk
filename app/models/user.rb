class User
  include Mongoid::Document
  include Mongoid::Timestamps

  has_and_belongs_to_many :following, class_name: 'User', inverse_of: :followers, autosave: true
  has_and_belongs_to_many :followers, class_name: 'User', inverse_of: :following

  def self.get_user uid
    self.where(uid: uid).first
  end

  def follow!(user)
    if self.id != user.id && !self.following.include?(user)
      self.following << user
    end
  end

  def unfollow!(user)
    self.following.delete(user)
  end


  def self.generate_user_id
    self.count + 1
  end

  def self.list_all_users
    self.all(sort: [[ :created_at, :desc ]])
  end

  def self.create_new_user first_name, last_name, e_mail
   self.create(uid: self.generate_user_id.to_s, first_name: first_name, last_name: last_name, e_mail: e_mail)
  end

  def self.create_users
    (1..1000).each do |f|
      user = self.new(uid: f.to_s, first_name: "first_name", last_name: "last_name", e_mail: "e_mail")
      user.save!
      puts f
      puts user.uid
    end
  end

  def self.delete_user(uid)
    user = User.find(uid)
    user.destroy
  end

  def self.delete_users
    self.delete_all
  end

  field :uid, :type => String, :default => self.generate_user_id
  field :first_name, :type => String
  field :last_name, :type => String
  field :e_mail, :type => String
  field :messages, :type => String

  #index :uid, unique: true

  attr_accessible :uid, :first_name, :last_name, :e_mail
  validates_presence_of :uid, :first_name, :last_name, :e_mail
  validates_uniqueness_of :uid

  has_many :messages
end
