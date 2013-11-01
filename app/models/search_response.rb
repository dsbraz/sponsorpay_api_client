require 'digest/sha1'

class SearchResponse < Struct.new(:response)
  def valid?(api_key)
    case response.code
    when 200
      valid_signature? api_key
    when 400
      raise error_message('Bad request')
    when 401
      raise error_message('Unauthorized')
    when 404
      raise error_message('Not found')
    when 500
      raise error_message('Internal Server Error')
    when 502
      raise error_message('Bad Gateway')
    else
      raise error_message('Unknow problem')
    end
  end

  def last_uri
    response.request.last_uri
  end

  private

  def error_message(message)
    Rails.logger.error "\nError => #{response.code} #{response['code']}\n"
    "SponsorPay API: #{response.code} #{message} #{response['code']}"
  end

  def valid_signature?(api_key)
    hash = Digest::SHA1.hexdigest(response.body + api_key)
    Rails.logger.debug "Response calculated signature => #{hash}"
    Rails.logger.debug "Response signature => #{response.header['X-Sponsorpay-Response-Signature']}"
    hash == response.header['X-Sponsorpay-Response-Signature']
  end
end
