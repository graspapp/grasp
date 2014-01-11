class Contact < MailForm::Base
  attribute :name
  attribute :email, validate: /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attribute :subject
  attribute :message

  validates_presence_of :name, :email, :subject, :message

  def headers
    {
      subject: "#{subject} | Grasp",
      to: Figaro.env.contact_email,
      from: %("#{name}" <#{email}>)
    }
  end
end
