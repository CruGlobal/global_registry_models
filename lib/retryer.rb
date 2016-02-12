## Class that will keep reattempting requests to the API
class Retryer
  attr_accessor :attempt_number, :sleepiness,
                :exception_classes, :max_number_of_attempts

  def initialize(*exception_classes, max_attempts: 7)
    self.attempt_number = 1
    self.sleepiness = 0
    self.max_number_of_attempts = max_attempts
    self.exception_classes = exception_classes.presence || [StandardError]
  end

  def try
    yield
  rescue => exception
    raise exception unless retry_exception?(exception)
    puts "Retryer rescued #{exception.inspect} on attempt
          #{attempt_number}, sleeping for #{sleepiness} seconds."
    sleep sleepiness
    increase_sleepiness
    puts "Retryer attempting retry #{attempt_number += 1}.
          #{' This is the last attempt!' if last_attempt?}"
    retry
  end

  private

  def retry_exception?(exception)
    exception_classes.include?(exception.class) && !last_attempt?
  end

  def last_attempt?
    return false if max_number_of_attempts.nil?
    attempt_number >= max_number_of_attempts
  end

  def increase_sleepiness
    return self.sleepiness = 1 if sleepiness <= 0
    self.sleepiness = [1000, (sleepiness * 2)].min
  end
end
