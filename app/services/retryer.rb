class Retryer

  attr_accessor :retries, :sleepiness, :exception_classes

  def initialize(exception_classes = nil)
    self.retries = 0
    self.sleepiness = 0
    self.exception_classes = exception_classes
  end

  def self.only_on(exception_classes)
    self.new(exception_classes)
  end

  def forever
    yield
  rescue => exception
    raise exception unless retry_exception?(exception)
    puts "Retryer rescued #{ exception.inspect }, sleeping for #{ self.sleepiness} seconds"
    sleep self.sleepiness
    increase_sleepiness
    puts "Attempting retry number #{ self.retries += 1 }"
    retry
  end

  private

    def retry_exception?(exception)
      self.exception_classes.present? ? self.exception_classes.include?(exception.class) : true
    end

    def increase_sleepiness
      self.sleepiness = 1 if self.sleepiness <= 0
      self.sleepiness = [100000, (self.sleepiness * 2)].min
    end

end
