require 'httparty'

class OMDBClient
  include HTTParty

  def initialize(omdburl='http://www.omdbapi.com/', format=:json, plot='short', tomatoes=true)
    self.class.base_uri omdburl
    self.class.format format

    @common_options = {}
    @common_options[:r] = format.to_s.upcase
    @common_options[:plot] = plot
    @common_options[:tomatoes] = tomatoes
  end

  def request(query, path='')
    query.merge! @common_options

    self.class.get(path, { :query => query })
  end

  def search(term, year=nil)
    query = { :s => term }
    query[:y] = year if year

    request query
  end

  def title(name, year=nil)
    query = { :t => name }
    query[:y] = year if year

    request query
  end

  def id(name)
    query = { :i => id }

    request query
  end
end
