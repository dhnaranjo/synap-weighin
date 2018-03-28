class NewTopScoreMailer < ApplicationMailer
  def email(person, previously_in_first=nil)
    @person = person
    @previously_in_first = previously_in_first
    mail(to: 'kev@kevinmchugh.me', subject: "#{person.name} has taken the lead!")
  end

  def no_longer_first_email(email, person, previously_in_first, tie)
    @person = person
    @previously_in_first = previously_in_first
    @tie = tie
    subject = tie ? "#{person.name} has tied you for first place!" : "#{person.name} has knocked you out of first place!"
    mail(to: email, subject: subject, bcc: 'kev@kevinmchugh.me')
  end

  def now_in_first_email(email, person, previously_in_first, tie)
    @person = person
    @previously_in_first = previously_in_first
    @tie = tie
    subject = tie ? "You are now tied for first place with #{previously_in_first.name}" : "You have taken first place from #{previously_in_first.name}"
    mail(to: email, subject: subject, bcc: 'kev@kevinmchugh.me')
  end
end
