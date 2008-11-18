module Authentication
  module ByPassword
    # Stuff directives into including module
    def self.included(recipient)
      recipient.extend(ModelClassMethods)
      recipient.class_eval do
        include ModelInstanceMethods
        
        # Virtual attribute for the unencrypted password
        attr_accessor :password
        validates_presence_of     :password,                   :if => :password_required?
        validates_presence_of     :password_confirmation,      :if => :password_required?
        validates_confirmation_of :password,                   :if => :password_required?
        validates_length_of       :password, :within => 6..40, :if => :password_required?
        before_save :encrypt_password
      end
    end # #included directives

    #
    # Class Methods
    #
    module ModelClassMethods
      
      def password_digest(password, salt)
        digest = nil
        5.times do
          digest = secure_digest(digest, salt, password)
        end
        digest
      end
    end # class methods

    #
    # Instance Methods
    #
    module ModelInstanceMethods
      
      # Encrypts the password with the user salt
      def encrypt(password)
        self.class.password_digest(password, salt)
      end
      
      def authenticated?(password)
        crypted_password == encrypt(password)
      end
      
      # before filter 
      def encrypt_password
        return if password.blank?
        self.salt = self.class.make_token if new_record?
        self.crypted_password = encrypt(password)
      end
      
      def password_required?
        crypted_password.blank? || !password.blank?
      end
    end # instance methods
  end
end
