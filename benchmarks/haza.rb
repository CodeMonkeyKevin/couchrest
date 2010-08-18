require 'rubygems'
require 'benchmark'

if RUBY_VERSION =~ /1.9/
  $: << File.dirname(__FILE__)
  require_relative '../lib/couchrest'
else
  require '../lib/couchrest'
end

@iterations = 100

@payload = {:key => 'value', 'another key' => 'another value'}
@db_url = "http://127.0.0.1:5984/testdb"

def run_curb
  CouchRest.adapter = :curb
  @db = CouchRest.database(@db_url)
  @db.recreate!
  @last_doc = nil

  Benchmark.bm do |x|
    CouchRest.adapter = :curb
    x.report("       Curb-PUT") do
      @iterations.times do
        @last_doc = @db.save_doc(@payload)
      end
    end
    
    x.report("       Curb-GET") do
      @iterations.times do
        @db.get(@last_doc['id'])
      end
    end

    x.report("      Curb-POST") do
      @iterations.times do
        @db.bulk_save([
            {"wild" => "and random"},
            {"mild" => "yet local"},
            {"another" => ["set","of","keys"]}
          ])
      end
    end
  end
end

def run_restclient
  CouchRest.adapter = :restclient
  @db = CouchRest.database(@db_url)
  @db.recreate!
  @last_doc = nil

  Benchmark.bm do |x|
    x.report(" RestClient-PUT") do
      @iterations.times do
        @last_doc = @db.save_doc(@payload)
      end
    end

    x.report(" RestClient-GET") do
      @iterations.times do
        @db.get(@last_doc['id'])
      end
    end

    x.report("RestClient-POST") do
      @iterations.times do
        @db.bulk_save([
            {"wild" => "and random"},
            {"mild" => "yet local"},
            {"another" => ["set","of","keys"]}
          ])
      end
    end
  end
end

run_curb
run_curb
run_restclient
run_restclient
