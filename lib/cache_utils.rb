module CacheUtils
  module_function

  def fetch_cache(key)
    cache = cache_client

    begin
      cached_response = cache.get(key)
      return cached_response if cached_response
    rescue => e
      logger.warn(e)
      Rollbar.warning(e)
    end

    response = yield

    begin
      cache.set(key, response)
    rescue => e
      logger.warn(e)
      Rollbar.warning(e)
    end

    response
  end

  def cache_client
    return @cache_client if @cache_client

    Dalli.logger.level = Logger::WARN

    @cache_client = Dalli::Client.new(Global.memcached.servers, Global.memcached.options.to_hash.symbolize_keys)
  end
end
