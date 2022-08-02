class ApplicationService
  class << self
    def call(*args, **options, &block)
      new(*args, **options).call(&block)
    end
  end
 
  def call(&_block)
    raise NotImplementedError
  end
end
