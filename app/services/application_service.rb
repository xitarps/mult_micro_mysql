class ApplicationService
  def initialize(*args, **kwargs, &block)
    super
  end

  def call
    run
  end

  def self.call(...)
    new(...).call
  end

  private

  def run
    raise 'Must implement method private \'run\''
  end
end
